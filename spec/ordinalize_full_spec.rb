require "ordinalize_full/integer"

describe OrdinalizeFull do
  describe "#ordinalize_in_full" do
    context "with the default locale (:en)" do
      before { I18n.locale = :en }

      specify { expect(1.ordinalize_in_full).to eq("first") }
      specify { expect(42.ordinalize_in_full).to eq("forty second") }

      it "raises with unknown numbers" do
        expect { 101.ordinalize_in_full }.to raise_error(NotImplementedError)
      end
    end

    context "with locale = :fr" do
      before { I18n.locale = :fr }

      specify { expect(1.ordinalize_in_full).to eq("premier") }
      specify { expect(42.ordinalize_in_full).to eq("quarante-deuxième") }
    end

    context "with locale = :nl" do
      before { I18n.locale = :nl }

      specify { expect(1.ordinalize_in_full).to eq("eerste") }
      specify { expect(22.ordinalize_in_full).to eq("tweeëntwintigste") }
    end
  end

  describe "#ordinalize_full" do
    specify { expect(1.ordinalize_full).to eq(1.ordinalize_in_full) }
  end

  describe "#ordinalize" do
    context "with the default locale (:en)" do
      before { I18n.locale = :en }

      specify { expect(1.ordinalize(in_full: true)).to eq("first") }
      specify { expect(1.ordinalize(in_full: false)).to eq("1st") }
    end

    context "with locale = :fr" do
      before { I18n.locale = :fr }

      specify { expect(1.ordinalize(in_full: true)).to eq("premier") }
      specify { expect(1.ordinalize(in_full: false)).to eq("1er") }
    end

    context "with locale = :it" do
      before { I18n.locale = :it }

      specify { expect(1.ordinalize(in_full: true)).to eq("primo") }
      specify { expect(1.ordinalize(in_full: false)).to eq("1°") }
    end

    context "with locale = :nl" do
      before { I18n.locale = :nl }

      specify { expect(1.ordinalize(in_full: true)).to eq("eerste") }
      specify { expect(1.ordinalize(in_full: false)).to eq("1ste") }
    end
  end
end
