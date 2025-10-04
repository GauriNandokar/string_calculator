require_relative "../string_calculator"

RSpec.describe StringCalculator do
  describe ".add" do
    it "returns 0 for empty string" do
      expect(StringCalculator.add("")).to eq(0)
    end

    it "returns the number if input is single number" do
      expect(StringCalculator.add("5")).to eq(5)
    end
  end
end