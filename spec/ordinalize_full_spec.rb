require "ordinalize_full/integer"

describe OrdinalizeFull do
  describe "#ordinalize_in_full" do
    context "with the default locale (:en)" do
      specify { expect(1.ordinalize_in_full).to eq("first") }
      specify { expect(42.ordinalize_in_full).to eq("forty second") }
    end

    context "with locale = :fr" do
      before { I18n.locale = :fr }

      specify { expect(1.ordinalize_in_full).to eq("premier") }
      specify { expect(42.ordinalize_in_full).to eq("quarante-deuxième") }
    end
  end

  describe "#ordinalize_full" do
    specify { expect(1.ordinalize_full).to eq(1.ordinalize_in_full) }
  end
end

