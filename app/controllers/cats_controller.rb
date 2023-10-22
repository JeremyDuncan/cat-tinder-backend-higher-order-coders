class CatsController < ApplicationController

  def index 
    @cats = Cat.all
  end

  def create
    @cat = Cat.create(cat_params)

    if @cat.valid?
      redirect_to cats_path, notice: 'Cat profile was successfully created.'
    else
      render :new
    end
  end

  def show
    @cat = Cat.find(params[:id])

  end
  def edit
    @cat = Cat.find(params[:id])
  end
  def update
    @cat = Cat.find(params[:id])
    @cat.update(cat_params)
  end

  def destroy
    @cat = Cat.find_by(id: params[:id])
    if @cat
      @cat.destroy
      redirect_to cats_path, notice: 'Cat was successfully deleted.'
    else
      redirect_to cats_path, alert: 'Cat not found.'
    end
  end

  def delete
    @cat = Cat.find(params[:id])
    @cat.destroy
    redirect_to cats_path, notice: 'Cat was successfully deleted.'
  end

  private
  def cat_params
    params.require(:cat).permit(:name, :age, :enjoys, :image)
  end

end
