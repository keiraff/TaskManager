# frozen_string_literal: true

class CategoriesController < AuthenticatedController
  def index
    @categories = current_user.categories
  end
end
