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

    it "raises error for single negative number" do
      expect { StringCalculator.add("1,-2,3") }.to raise_error("Negatives not allowed: -2")
    end

    it "raises error for multiple negative numbers" do
      expect { StringCalculator.add("1,-2,3,-4") }.to raise_error("Negatives not allowed: -2,-4")
    end

    it "ignores numbers greater than 1000" do
      expect(StringCalculator.add("2,1001")).to eq(2)
    end

    it "supports delimiters of any length" do
      expect(StringCalculator.add("//[***]\n1***2***3")).to eq(6)
    end
  end

  describe ".get_called_count" do
    it "returns the number of times add was called" do
      # Reset call count at the start of test
      StringCalculator.reset_called_count if StringCalculator.respond_to?(:reset_called_count)

      expect(StringCalculator.get_called_count).to eq(0)

      StringCalculator.add("1,2")
      StringCalculator.add("3,4")

      expect(StringCalculator.get_called_count).to eq(2)
    end
  end

  describe "AddOccured event" do
    before(:each) do
      StringCalculator.reset_callbacks
    end

    it "triggers AddOccured after add is called" do
      triggered_input = nil
      triggered_result = nil

      StringCalculator.on_add_occurred do |input, result|
        triggered_input = input
        triggered_result = result
      end

      result = StringCalculator.add("1,2,3")

      expect(triggered_input).to eq("1,2,3")
      expect(triggered_result).to eq(6)
      expect(result).to eq(6)
    end
  end
end