class CatsController < ApplicationController

  def index 
    @cats = Cat.all
  end


  def new
    @cat = Cat.new
    @cat.cat_images.build  # This line builds an associated cat_image for the new Cat instance
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

  # def update
  #   @cat = Cat.find(params[:id])
  #   if @cat.update(cat_params)
  #     redirect_to @cat, notice: 'Cat profile was successfully updated.'
  #   else
  #     render :edit
  #   end
  # end
  def update
    @cat = Cat.find(params[:id])
    puts ""
    puts "===================="
    puts "params[:id] => #{params[:id]}"
    puts "@cat => #{@cat}"

    # Filter out empty image strings
    filtered_params = cat_params.deep_dup
    puts ""
    puts "filtered_params INITIAL=> #{filtered_params}"

    filtered_params[:cat_images_attributes].each do |key, attributes|
      puts ""
      puts "attributes[:image] => #{attributes[:image]}"
      # pp attributes[:image].inspect

      if attributes[:image].is_a?(Array)
        attributes[:image].reject!(&:blank?)
      end
    end
    puts ""
    puts "filtered_params AFTER=> #{filtered_params}"

    if @cat.update(filtered_params)
      redirect_to @cat, notice: 'Cat profile was successfully updated.'
    else
      render :edit
    end
  end





  # def destroy
  #   @cat = Cat.find_by(id: params[:id])
  #   if @cat
  #     @cat.destroy
  #     redirect_to cats_path, notice: 'Cat was successfully deleted.'
  #   else
  #     redirect_to cats_path, alert: 'Cat not found.'
  #   end
  # end

  def delete
    @cat = Cat.find(params[:id])
    @cat.destroy
    redirect_to cats_path, notice: 'Cat was successfully deleted.'
  end

  private

  def cat_params
    params.require(:cat).permit(:name, :age, :enjoys,
                                cat_images_attributes: [:id, :image, :_destroy])
  end


  # def cat_params
  #   params.require(:cat).permit(:name, :age, :enjoys,
  #                               cat_images_attributes: [:id, :image, :_destroy], images: [])
  # end
  # def cat_params
  #   params.require(:cat).permit(:name, :age, :enjoys,
  #                               cat_images_attributes: [:id, { image: [] }, :_destroy])
  # end


end
