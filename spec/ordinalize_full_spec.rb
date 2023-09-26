# frozen_string_literal: true

require "ordinalize_full/integer"

describe OrdinalizeFull do
  describe "#ordinalize_in_full" do
    context "with the default locale (:en)" do
      before { I18n.locale = :en }

      specify { expect(1.ordinalize_in_full).to eq("First") }
      specify { expect(42.ordinalize_in_full).to eq("Forty-Second") }
      specify { expect(2023.ordinalize_in_full).to eq("Two Thousand and Twenty-Third") }
      specify { expect(2147483647.ordinalize_in_full).to eq("Two Billion One Hundred and Forty-Seven Million Four Hundred and Eighty-Three Thousand Six Hundred and Forty-Seventh") }

      it "converts any number" do
        rand = Random.new
        10.times do
          expect { rand(1000000).ordinalize_in_full }.not_to raise_error
        end
      end

      it "handles negatives too" do
        expect(-273.ordinalize_in_full).to eq("Negative Two Hundred and Seventy-Third")
      end
    end

    context "with locale = :fr" do
      before { I18n.locale = :fr }

      specify { expect(1.ordinalize_in_full).to eq("premier") }
      specify { expect(1.ordinalize_in_full(gender: :feminine)).to eq("première") }
      specify { expect(42.ordinalize_in_full).to eq("quarante-deuxième") }
    end

    context "with locale = :nl" do
      before { I18n.locale = :nl }

      specify { expect(1.ordinalize_in_full).to eq("eerste") }
      specify { expect(22.ordinalize_in_full).to eq("tweeëntwintigste") }
    end

    context "with locale = :es" do
      before { I18n.locale = :es }

      specify { expect(1.ordinalize_in_full(gender: :feminine, plurality: :plural)).to eq("primeras") }
      specify { expect(1.ordinalize_in_full).to eq("primer") }
      specify { expect(13.ordinalize_in_full(gender: :feminine, plurality: :plural)).to eq("decimoterceras") }
      specify { expect(13.ordinalize_in_full).to eq("decimotercer") }
      specify { expect(14.ordinalize_in_full(gender: :feminine, plurality: :plural)).to eq("decimocuartas") }
      specify { expect(55.ordinalize_in_full).to eq("quincuagésimo quinto") }
      specify { expect(22.ordinalize_in_full(gender: :feminine, plurality: :plural)).to eq("vigésima segundas") }
      specify { expect(22.ordinalize_in_full(gender: :feminine)).to eq("vigésima segunda") }
      specify { expect(22.ordinalize_in_full(gender: :feminine, plurality: :singular)).to eq("vigésima segunda") }
    end
  end

  describe "#ordinalize_full" do
    specify { expect(1.ordinalize_full).to eq(1.ordinalize_in_full) }
  end

  describe "#ordinalize" do
    context "with the default locale (:en)" do
      before { I18n.locale = :en }

      specify { expect(1.ordinalize(in_full: true)).to eq("First") }
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

    context "with locale = :es" do
      before { I18n.locale = :es }

      specify { expect(1.ordinalize(gender: :feminine, plurality: :plural)).to eq("1.ᵃˢ") }
      specify { expect(1.ordinalize).to eq("1.ᵉʳ") }
      specify { expect(13.ordinalize(gender: :feminine, plurality: :plural)).to eq("13.ᵃˢ") }
      specify { expect(13.ordinalize).to eq("13.ᵉʳ") }
      specify { expect(14.ordinalize(gender: :feminine, plurality: :plural)).to eq("14.ᵃˢ") }
      specify { expect(55.ordinalize).to eq("55.ᵒ") }
      specify { expect(22.ordinalize(gender: :feminine, plurality: :plural)).to eq("22.ᵃˢ") }
    end
  end
end
