# frozen_string_literal: true

class CategoriesController < AuthenticatedController
  before_action :set_category, only: [:destroy]

  def index
    @pagy, @categories = pagy(categories_scope)
  end

  def new
    @category = categories_scope.new
  end

  def create
    @category = categories_scope.new(category_params)

    if @category.save
      flash[:success] = "Category created!"
      redirect_to categories_url
    else
      flash.now[:danger] = "Something went wrong :("
      render "new"
    end
  end

  def destroy
    @category.destroy

    flash[:success] = "Category deleted!"
    redirect_to categories_url
  end

  private

  def set_category
    @category = Category.find_by(id: params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end

  def categories_scope
    current_user.categories
  end
end
