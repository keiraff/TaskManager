# frozen_string_literal: true

RSpec.describe Location::Show do
  subject(:service) { described_class.call(country: country, state: state) }

  let(:country) { nil }
  let(:state) { nil }

  context "when get states" do
    let(:country) { "US" }

    it "returns states" do
      expect(service.value).to eq({ cities: nil, states: CS.states(country) })
    end
  end

  context "when get cities and states" do
    let(:country) { "US" }
    let(:state) { "NY" }

    it "returns cities" do
      expect(service.value).to eq({ cities: CS.cities(state, country), states: CS.states(country) })
    end
  end

  context "when invalid params" do
    it "returns nil" do
      expect(service.value).to eq({ cities: nil, states: nil })
    end
  end
end
