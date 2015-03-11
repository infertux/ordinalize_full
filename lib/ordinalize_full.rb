require "i18n"

module OrdinalizeFull
  I18n.load_path += Dir[File.join(__dir__, "ordinalize_full/locales/*.yml")]

  def ordinalize(in_full: false)
    in_full ? ordinalize_in_full : ordinalize_in_short
  end

  alias_method :ordinalize_full, \
  def ordinalize_in_full
    begin
      I18n.t("ordinalize_full.n_#{self}", throw: true)
    rescue ArgumentError
      raise NotImplementedError, "Unknown locale #{I18n.locale}"
    end
  end

private

  def ordinalize_in_short
    abs_number = self.to_i.abs

    suffix = case I18n.locale
    when :en
      if (11..13).include?(abs_number % 100)
        "th"
      else
        case abs_number % 10
          when 1; "st"
          when 2; "nd"
          when 3; "rd"
          else    "th"
        end
      end
    when :fr
      self == 1 ? "er" : "ème"
    when :it
      "°"
    when :nl
      self % 100 == 8 || self % 100 == 1 || self % 100 > 19 || self % 100 == 0 ? "ste" : "de"
    end

    [self, suffix].join
  end
end

