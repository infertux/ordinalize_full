# frozen_string_literal: true

require "i18n"

# Main module
module OrdinalizeFull
  I18n.load_path += Dir[File.join(__dir__, "ordinalize_full/locales/*.yml")]

  def ordinalize(in_full: false, gender: :masculine, plurality: :singular)
    if in_full
      ordinalize_in_full(gender: gender, plurality: plurality)
    else
      ordinalize_in_short(gender: gender, plurality: plurality)
    end
  end

  def ordinalize_in_full(gender: :masculine, plurality: :singular)
    case I18n.locale
    when :fr
      value = I18n.t("ordinalize_full.n_#{self}_#{gender}", throw: false, default: "")
      value = I18n.t("ordinalize_full.n_#{self}", throw: true) if value.empty?
      value
    when :es
      value = I18n.t("ordinalize_full.n_#{self}", throw: false, default: "")

      if value.empty?
        value = [
          I18n.t("ordinalize_full.n_#{(self / 10) * 10}", throw: true),
          I18n.t("ordinalize_full.n_#{self % 10}", throw: true)
        ].join(" ")
      end

      value = value.split.map { |part| part.chop << "a" }.join(" ") if gender == :feminine
      value << "s" if plurality == :plural
      value = value.chop if value.end_with?("ero")

      value
    else
      begin
        integer_to_long_form_ordinal
      rescue ArgumentError
        I18n.t("ordinalize_full.n_#{self}", throw: true)
      end
    end
  rescue ArgumentError
    raise NotImplementedError, "Unknown locale #{I18n.locale}"
  end

  alias_method :ordinalize_full, :ordinalize_in_full

private

  def ordinalize_in_short(gender: :masculine, plurality: :singular)
    abs_number = to_i.abs
    suffix = \
      case I18n.locale
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

  # Build the long form of a given number. In this context, it is used for every digit except the last two.
  # @param number [Integer] - A number to write in long form
  # @return [String] - The long form of a number
  def number_to_word(number)
    if number.zero?
      I18n.t("long_form.simple.ones.n_0", throw: true)
    elsif number < 20
      I18n.t("long_form.simple.ones.n_#{number}", throw: true)
    elsif number < 100
      [
        I18n.t("long_form.simple.tens.n_#{number / 10}", throw: true),
        (number % 10).zero? ? "" : "-#{I18n.t("long_form.simple.ones.n_#{number % 10}", throw: true)}"
      ].join
    elsif number < 1000
      [
        I18n.t("long_form.simple.ones.n_#{number / 100}", throw: true),
        " ",
        I18n.t("long_form.simple.hundred", throw: true),
        (number % 100).zero? ? "" : " and #{number_to_word(number % 100)}"
      ].join
    else
      i = 0
      meow = number
      while meow >= 1000
        meow /= 1000
        i += 1
      end
      the_one_tenth = number % ((10**(3 * i)))
      [
        number_to_word(meow),
        " ",
        i.positive? ? I18n.t("long_form.simple.larger.n_#{i}", throw: true) : "",
        the_one_tenth.zero? ? "" : " #{number_to_word(the_one_tenth)}"
      ].join
    end
  end

  # Builds the ordinalized version of a number. Specific to english. Really only the two least significant digits are
  # ordinalized, and the rest are just in long format
  # @param number [Integer] - A number to ordinalize in long form
  # @return [String] - The long form of a number as an ordinal
  def number_to_ordinal_word(number)
    if number.zero?
      I18n.t("long_form.ordinal.ones.n_0", throw: true)
    elsif number < 20
      I18n.t("long_form.ordinal.ones.n_#{number}", throw: true)
    elsif number < 100 && (number % 10).zero?
      I18n.t("long_form.ordinal.tens.n_#{number / 10}", throw: true)
    elsif number < 100
      "#{number_to_word(number - (number % 10))}-#{I18n.t("long_form.ordinal.ones.n_#{number % 10}", throw: true)}"
    elsif number >= 100 && (number % 100).zero?
      "#{number_to_word(number - (number % 100))}th"
    else
      "#{number_to_word(number - (number % 100))} and #{number_to_ordinal_word((number % 100))}"
    end
  end

  # Builds the long form ordinal of an integer
  # @return [String] - The long form ordinal of an integer (including negative)
  def integer_to_long_form_ordinal
    return "#{I18n.t('long_form.negative', throw: true)} #{number_to_ordinal_word(-self)}" if negative?

    number_to_ordinal_word(self)
  end
end
