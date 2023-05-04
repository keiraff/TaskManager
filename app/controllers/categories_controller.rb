# frozen_string_literal: true

class CategoriesController < AuthenticatedController
  def index
    @pagy, @categories = pagy(current_user.categories, items: 10)
  end

  def new
    @category = Category.new
  end

  def create
    @category = current_user.categories.new(category_params)

    if @category.save
      flash[:success] = "Category created!"
      redirect_to categories_url
    else
      flash[:error] = "Something went wrong :("
      render "new"
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
