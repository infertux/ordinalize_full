require "i18n"

module OrdinalizeFull
  I18n.load_path += Dir[File.join(__dir__, "ordinalize_full/locales/*.yml")]

  def ordinalize(in_full: false)
    in_full ? ordinalize_in_full : ordinalize_in_short
  end

  alias_method :ordinalize_full, :ordinalize
  def ordinalize_in_full
    I18n.t("ordinalize_full.n_#{self}", throw: true)
  rescue ArgumentError
    raise NotImplementedError, "Unknown locale #{I18n.locale}"
  end

private

  def ordinalize_in_short
    abs_number = to_i.abs

    suffix = case I18n.locale
    when :en
      if (11..13).cover?(abs_number % 100)
        "th"
      else
        case abs_number % 10
        when 1 then "st"
        when 2 then "nd"
        when 3 then "rd"
        else "th"
        end
      end
    when :fr
      self == 1 ? "er" : "ème"
    when :it
      "°"
    when :nl
      [8, 1, 0].include?(self % 100) || self % 100 > 19 ? "ste" : "de"
    end

    [self, suffix].join
  end
end
