class BbqsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  def index

    @index = true # this passes a variable to confirm to the navbar we are on index
                  # so that it can show us the filter by bar
    if params[:filter]
      case params[:filter]
      when 'brand'
        @bbqs = Bbq.order(:manufacturer)
      when 'priceA'
        @bbqs = Bbq.order('price ASC')
      when 'priceD'
        @bbqs = Bbq.order('price DESC')
      end
    else
      @bbqs = Bbq.all
    end
  end

  def show
    @bbq = Bbq.find(params[:id])
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

  def bbq_params
    params.require(:bbq).permit(:title, :description, :price, :manufacturer, :location, photos: [])
  end
end
