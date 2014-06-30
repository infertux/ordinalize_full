require "i18n"

module OrdinalizeFull
  I18n.load_path << Dir[File.join(__dir__, "ordinalize_full/locales/*.yml")]

  def ordinalize(in_full: false)
    if in_full
      self.ordinalize_in_full
    else
      require "active_support/inflector"
      ActiveSupport::Inflector.ordinalize(self)
    end
  end

  def ordinalize_in_full
    I18n.t("ordinalize_full.n_#{self}")
  end

  alias_method :ordinalize_full, :ordinalize_in_full
end

