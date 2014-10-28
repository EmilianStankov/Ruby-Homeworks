class NumberSet
  include Enumerable

  def initialize(numbers = [])
    @numbers = numbers
  end

  def <<(number)
    @numbers << number unless @numbers.include? number
  end

  def size
    @numbers.size
  end

  def empty?
    @numbers.empty?
  end

  def [](filter)
    NumberSet.new(filter.filter(@numbers))
  end

  def each(&block)
    @numbers.each { |number| block.call number } if block_given?
    @numbers.to_enum unless block_given?
  end
end


class Filter
  def initialize(&block)
    @block = block
  end

  def filter(numbers)
    numbers.select(&@block)
  end

  def &(other)
    IntersectionFilter.new(self, other)
  end

  def |(other)
    UnionFilter.new(self, other)
  end
end


class SignFilter < Filter
  def initialize(sign)
    @sign = sign
  end

  def filter(numbers)
    numbers.each_with_object([]) do |number, filtered|
      filtered << number if @sign == :positive and number > 0
      filtered << number if @sign == :negative and number < 0
      filtered << number if @sign == :non_negative and number >= 0
      filtered << number if @sign == :non_positive and number <= 0
    end
  end
end


class TypeFilter < Filter
  def initialize(type)
    @type = type
  end

  def filter(numbers)
    numbers.each_with_object([]) do |number, filtered|
      filtered << number if @type == :real and is_real?(number)
      filtered << number if @type == :integer and number.is_a? Integer
      filtered << number if @type == :complex and number.is_a? Complex
    end
  end

  def is_real?(number)
    number.is_a? Float or number.is_a? Rational
  end
end


class IntersectionFilter < Filter
  def initialize(first_filter, second_filter)
    @first_filter = first_filter
    @second_filter = second_filter
  end

  def filter(numbers)
    @first_filter.filter(@second_filter.filter(numbers))
  end
end


class UnionFilter < Filter
  def initialize(first_filter, second_filter)
    @first_filter = first_filter
    @second_filter = second_filter
  end

  def filter(numbers)
    result = @first_filter.filter(numbers)
    @second_filter.filter(numbers).each do |number|
      result << number
    end
    result
  end
end