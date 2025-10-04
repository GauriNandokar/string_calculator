require_relative "../string_calculator"

RSpec.describe StringCalculator do
  describe ".add" do
    it "returns 0 for empty string" do
      expect(StringCalculator.add("")).to eq(0)
    end

    it "returns the number if input is single number" do
      expect(StringCalculator.add("5")).to eq(5)
    end

    it "returns sum of two comma-separated numbers" do
      expect(StringCalculator.add("1,2")).to eq(3)
    end

    it "returns sum of multiple numbers" do
      expect(StringCalculator.add("1,2,3,4")).to eq(10)
    end

    it "handles newlines as delimiters" do
      expect(StringCalculator.add("1\n2,3")).to eq(6)
    end

    it "supports custom delimiters" do
      expect(StringCalculator.add("//;\n1;2")).to eq(3)
    end

    it "raises error for negative numbers" do
      expect { StringCalculator.add("1,-2,3") }.to raise_error("Negatives not allowed: -2")
    end
  end
end