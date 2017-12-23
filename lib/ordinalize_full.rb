# frozen_string_literal: true

require "i18n"

module OrdinalizeFull
  I18n.load_path += Dir[File.join(__dir__, "ordinalize_full/locales/*.yml")]

  def ordinalize(in_full: false, gender: :masculine, plurality: :singular)
    if in_full
      ordinalize_in_full(gender: gender, plurality: plurality)
    else
      ordinalize_in_short(gender: gender, plurality: plurality)
    end
  end

  alias_method :ordinalize_full, \
  def ordinalize_in_full(gender: :masculine, plurality: :singular)
    case I18n.locale
    when :es
      value = I18n.t("ordinalize_full.n_#{self}", throw: false, default: "")

      if value.empty?
        value = [
          I18n.t("ordinalize_full.n_#{(self / 10) * 10}", throw: true),
          I18n.t("ordinalize_full.n_#{self % 10}", throw: true)
        ].join(" ")
      end

      if gender == :feminine
        value = value.split.map { |part| part.chop << "a" }.join(" ")
      end

      value << "s" if plurality == :plural
      value = value.chop if value.end_with?("ero")

      value
    else
      I18n.t("ordinalize_full.n_#{self}", throw: true)
    end
  rescue ArgumentError
    raise NotImplementedError, "Unknown locale #{I18n.locale}"
  end

private

  def ordinalize_in_short(gender: :masculine, plurality: :singular)
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
      value = ordinalize_in_full(gender: gender, plurality: plurality)

      if value.end_with?("er")
        ".ᵉʳ"
      elsif value.end_with?("a")
        ".ᵃ"
      elsif value.end_with?("o")
        ".ᵒ"
      elsif value.end_with?("os")
        ".ᵒˢ"
      elsif value.end_with?("as")
        ".ᵃˢ"
      end
    end

    [self, suffix].join
  end
end
