# frozen_string_literal: true

require "ordinalize_full"

class Integer
  prepend OrdinalizeFull
end
