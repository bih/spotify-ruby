# frozen_string_literal: true

require "spec_helper"

RSpec.describe Spotify::SDK::Initialization do
  let(:sample_access_token) do
    "AQBjjlIYyEuyK2HuzqfA2ldj0B88d63KX2pgdOC0N4Pg4Iuw232M7gEgXjQS0Zdt3Y1r2J3G" \
    "rCOf4fs1JndDbyGY_uaPWj5hpYE_dMS0G5ouJKLaapDT50EysfV3XdW6aQlbw51dYjgZU-Ce" \
    "NCnj7bPsq4nXhZzbUkr0aTuR8MKEOXuW7-xaz1h8et-ZFYQDa788LTS08pLu--1waspBsmqh" \
    "SxbOl0xG5QBQ0NnTbCn1SWi-T1B7J_6twmv7GWXsR9RqeBg_U5KcT6ciz85YFrkRQ6n47PpP" \
    "HBfTFjmJxB91plroOOIZAE3fQ37-RDqdK7YzSw6gAm0"
  end
  let(:klass) { subject.class }
  let(:children) { klass::CLASSES }
  let(:children_klasses) do
    children.map {|child_klass_name| "Spotify::SDK::Initialization::%s" % child_klass_name }
  end

  describe "::CLASSES" do
    it "should be a flat symbolized array" do
      expect(children).to eq children.flatten.map(&:to_sym)
    end

    it "should contain valid classes" do
      expect { children_klasses.map(&:constantize) }.not_to raise_error
    end
  end

  describe ".detect" do
    context "good input" do
      it "should accept a plain string access token" do
        expect(klass.detect(sample_access_token)).to eq(access_token:  sample_access_token,
                                                        expires_in:    nil,
                                                        refresh_token: nil)
      end
    end

    context "bad input" do
      it "should raise an object invalid error if no matches" do
        expect {
          klass.detect(Object)
        }.to raise_error Spotify::Errors::InitializationObjectInvalidError
      end

      it "should raise an object duplication error if duplicate matches" do
        expect_any_instance_of(Spotify::SDK::Initialization::PlainString).to receive(:should_perform?).and_return(true)
        expect_any_instance_of(Spotify::SDK::Initialization::URLString).to receive(:should_perform?).and_return(true)

        expect {
          klass.detect(sample_access_token)
        }.to raise_error Spotify::Errors::InitializationObjectDuplicationError
      end
    end
  end
end
