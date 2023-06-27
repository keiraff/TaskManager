# frozen_string_literal: true

class CategoriesController < AuthenticatedController
  def index
    @pagy, @categories = pagy(categories_scope.order(id: :desc))
  end

  def new
    @category = categories_scope.new
  end

  def edit
    @category = category
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

  def update
    if category.update(category_params)
      flash[:success] = "Category updated!"
      redirect_to categories_url
    else
      flash.now[:danger] = "Something went wrong :("
      render "edit"
    end
  end

  def destroy
    category.destroy

    flash[:success] = "Category deleted!"
    redirect_to categories_url
  end

  private

  def category
    @category ||= categories_scope.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end

  def categories_scope
    current_user.categories
  end
end
