# frozen_string_literal: true

class CategoriesController < AuthenticatedController
  def index
    @pagy, @categories = pagy(current_user.categories)
  end

  def new
    @category = Category.new
  end
end
