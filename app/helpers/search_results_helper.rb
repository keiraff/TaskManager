# frozen_string_literal: true

module SearchResultsHelper
  def category_options
    options = current_user.categories.order(:name).map do |category|
      [category.truncated_name, category.id]
    end

    options_for_select(options, selected_category)
  end

  def selected_category
    return unless params[:query]

    params[:query]["category_id_eq"]
  end
end
