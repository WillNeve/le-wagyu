class BbqsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  def index
    @index = true # this passes a variable to confirm to the navbar we are on index
                  # so that it can show us the filter by bar
    if params[:filter]
      case params[:filter]
      when 'brand'
        @bbqs = Bbq.order(:manufacturer)
        @filter = 'brand'
      when 'priceA'
        @bbqs = Bbq.order('price ASC')
        @filter = 'priceA'
      when 'priceD'
        @bbqs = Bbq.order('price DESC')
        @filter = 'priceD'
      end
    elsif params[:query].present?
      sql_query = <<~SQL
        bbqs.title @@ :query
        OR bbqs.manufacturer @@ :query
        OR bbqs.location @@ :query
      SQL
      @bbqs = Bbq.where(sql_query, query: "%#{params[:query]}%")
    else
      @bbqs = Bbq.all
    end
    @markers = @bbqs.geocoded.map do |bbq|
      {
        lat: bbq.latitude,
        lng: bbq.longitude,
        info_window: render_to_string(partial: "info_window", locals: { bbq: bbq }),
        image_url: helpers.asset_url("marker-bbq.png")
      }
    end
  end

  def show
    @bbq = Bbq.find(params[:id])
    @booking = Booking.new
    @marker = [{
      lat: @bbq.latitude,
      lng: @bbq.longitude,
      info_window: render_to_string(partial: "info_window", locals: { bbq: @bbq }),
      image_url: helpers.asset_url("marker-bbq.png")
    }]
  end

  def new
    @bbq = Bbq.new
    @user = current_user
  end

  def create
    @bbq = Bbq.new(bbq_params)
    @user = current_user
    @bbq.user = @user
    if @bbq.save
      redirect_to bbq_path(@bbq)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def search
    search = params[:search].downcase.chomp
    @bbqs = Bbq.where('title = ?', search)
    @bbqs = Bbq.all if search == ''
    render :index
  end

  private

  def like
    @bbq = Bbq.find(params[:id])
    Like.create(user_id: current_user.id, bbq_id: @bbq.id)
    redirect_to bbq_path(@bbq)
  end

  def bbq_params
    params.require(:bbq).permit(:title, :description, :price, :manufacturer, :location, photos: [])
  end
end
