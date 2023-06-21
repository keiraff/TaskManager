# frozen_string_literal: true

class CategoriesController < AuthenticatedController
  def index
    @pagy, @categories = pagy(categories_scope.order(created_at: :desc))
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
    selected_category.destroy

    flash[:success] = "Category deleted!"
    redirect_to categories_url
  end

  private

  def selected_category
    @selected_category ||= categories_scope.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end

  def categories_scope
    current_user.categories
  end
end
