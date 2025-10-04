class StringCalculator
  def self.add(numbers)
    return 0 if numbers.empty?

    if numbers.start_with?("//")
      delimiter, numbers = numbers[2], numbers[4..]
      nums = numbers.split(delimiter).map(&:to_i)
    else
      nums = numbers.split(/,|\n/).map(&:to_i)
    end

    negatives = nums.select { |n| n < 0 }
    raise "Negatives not allowed: #{negatives.join(",")}" if negatives.any?

    nums.sum
  end
end