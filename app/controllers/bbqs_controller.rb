class BbqsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  def index
    @bbqs = Bbq.all
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

  private

  def bbq_params
    params.require(:bbq).permit(:title, :description, :price, :manufacturer, :location, photos: [])
  end
end
