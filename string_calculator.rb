class StringCalculator
  def self.add(numbers)
    return 0 if numbers.empty?

    if numbers.start_with?("//")
      delimiter, numbers = numbers[2], numbers[4..]
      nums = numbers.split(delimiter).map(&:to_i)
    else
      nums = numbers.split(/,|\n/).map(&:to_i)
    end

    nums.sum
  end
end