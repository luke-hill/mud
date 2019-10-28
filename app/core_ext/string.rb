# frozen_string_literal: true

class String
  def snake_case
    tr(' ', '_').downcase
  end
end
