class StringCalculator
  @@call_count = 0   # class variable to track calls

  def self.add(numbers)
    @@call_count += 1  # increment every time add is called

    return 0 if numbers.empty?

    if numbers.start_with?("//")
      delimiter, numbers = numbers[2], numbers[4..]
      nums = numbers.split(delimiter).map(&:to_i)
    else
      nums = numbers.split(/,|\n/).map(&:to_i)
    end

    negatives = nums.select { |n| n < 0 }
    raise "Negatives not allowed: #{negatives.join(",")}" if negatives.any?

    nums = nums.select { |n| n <= 1000 }

    nums.sum
  end

  def self.get_called_count
    @@call_count
  end

  def self.reset_called_count
    @@call_count = 0
  end
end