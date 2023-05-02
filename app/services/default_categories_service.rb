# frozen_string_literal: true

class DefaultCategoriesService < ApplicationService
  def initialize(user)
    @user = user
  end

  def call
    add_categories
  end

  private

  def add_categories
    @user.categories = Category.create([{ name: "Personal" },
                                        { name: "Work" },
                                        { name: "Vacation" }])
  end
end
