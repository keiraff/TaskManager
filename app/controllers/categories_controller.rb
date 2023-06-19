# frozen_string_literal: true

class CategoriesController < AuthenticatedController
  def index
    @pagy, @categories = pagy(current_user.categories)
  end
end
