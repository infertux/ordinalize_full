require "i18n"

module OrdinalizeFull
  I18n.load_path += Dir[File.join(__dir__, "ordinalize_full/locales/*.yml")]

  def ordinalize(in_full: false, noun_gender: :masculine  , noun_plurality: :singular)
    in_full ? ordinalize_in_full(noun_gender: noun_gender  , noun_plurality: noun_plurality) : ordinalize_in_short(noun_gender: noun_gender  , noun_plurality: noun_plurality)
  end

  alias_method :ordinalize_full, \
  def ordinalize_in_full(noun_gender: :masculine  , noun_plurality: :singular)
    case I18n.locale
    when :es
      value = I18n.t("ordinalize_full.n_#{self}", throw: false, default: "")
      if(value == "")
        value = [I18n.t("ordinalize_full.n_#{(self/10)*10}", throw: true),I18n.t("ordinalize_full.n_#{self%10}", throw: true)].join(" ")
      end
      
      if noun_gender == :feminine
        value = value.split.map{|value| value.chop << "a"}.join(" ")
      end
      if noun_plurality == :plural
        value << "s"
      end

      # if value ends in 1 or 3 shorten it , if it is masculine singular
      if value.end_with?("ero")
        value = value.chop
      end
      value
    else
      I18n.t("ordinalize_full.n_#{self}", throw: true)
    end

  rescue ArgumentError
    raise NotImplementedError, "Unknown locale #{I18n.locale}"
  end

private

  def ordinalize_in_short(noun_gender: :masculine  , noun_plurality: :singular)
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
    when :es
      full_ordinalized_val = ordinalize_in_full(noun_gender: noun_gender ,noun_plurality: noun_plurality)
      if full_ordinalized_val.end_with?("er")
        ".ᵉʳ"
      elsif full_ordinalized_val.end_with?("a")
        ".ᵃ" 
      elsif full_ordinalized_val.end_with?("o")
        ".ᵒ"
      elsif full_ordinalized_val.end_with?("os")
        ".ᵒˢ"
      elsif full_ordinalized_val.end_with?("as")
        ".ᵃˢ"
      end
    end

    [self, suffix].join
  end
end
