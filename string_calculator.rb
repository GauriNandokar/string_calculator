class StringCalculator
  @@call_count = 0   # class variable to track calls
  @@add_occurred_callbacks = []

  # Register a callback
  def self.on_add_occurred(&block)
    @@add_occurred_callbacks << block
  end

  # Reset callbacks (useful for tests)
  def self.reset_callbacks
    @@add_occurred_callbacks = []
  end

  def self.add(numbers)
    @@call_count += 1  # increment every time add is called
    return 0 if numbers.empty?

    nums = []

    if numbers.start_with?("//")
      # Check for any-length delimiter in square brackets
      if numbers =~ %r{//\[(.+)\]\n}
        delimiter = $1
        numbers = numbers.split("\n", 2).last
        nums = numbers.split(delimiter).map(&:to_i)
      else
        # Single-character delimiter (old behavior)
        delimiter, numbers = numbers[2], numbers[4..]
        nums = numbers.split(delimiter).map(&:to_i)
      end
    else
      # Default delimiters: comma or newline
      nums = numbers.split(/,|\n/).map(&:to_i)
    end

    negatives = nums.select { |n| n < 0 }
    raise "Negatives not allowed: #{negatives.join(",")}" if negatives.any?

    nums = nums.select { |n| n <= 1000 }

    result = nums.sum

    # Trigger all callbacks
    @@add_occurred_callbacks.each { |cb| cb.call(numbers, result) }

    result
  end

  def self.get_called_count
    @@call_count
  end

  def self.reset_called_count
    @@call_count = 0
  end
end
