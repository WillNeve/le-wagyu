class BbqsController < ApplicationController
  def index
    @bbqs = Bbq.all
  end

  def show
    @bbq = Bbq.find(params[:id])
  end

  def new
    @bbq = Bbq.new
    # @user = ???
  end

  def create
    @bbq = Bbq.new(bbq_params)
    raise
    # @bbq.user = @user
    if @bbq.save
      redirect_to bbq_path(@bbq)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def bbq_params
    params.require(:bbq).permit(:title, :description, :photos, :price, :manufacturer, :location)
  end
end
