# frozen_string_literal: true

class CategoriesController < AuthenticatedController
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

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def categories_scope
    current_user.categories
  end
end
