# frozen_string_literal: true

module CategoryDecorator
  def truncated_name
    truncate(name, length: 100)
  end
end
