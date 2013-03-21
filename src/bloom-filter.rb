require 'digest/md5'

class BitField
  def initialize(size)
    @size = size
    @field = Array.new(@size) {0}
  end

  def [](n)
    @field[n]
  end

  def []=(n, value)
    @field[n] = value
  end

  def to_s
    @field.join('').reverse
  end
end

# bf = BitField.new(128)

class BloomFilter
  def initialize(size, hashing_algorithm)
    @size = size
    @filter = BitField.new(@size)
    @algorithm = hashing_algorithm
  end

  def add(value)
    n1, n2, n3 = @algorithm.call(@size, value)
    puts "#{value} hashes to #{n1}, #{n2}, #{n3}"

    @filter[n1] = 1
    @filter[n2] = 1
    @filter[n3] = 1
  end

  def exists?(value)
    n1, n2, n3 = @algorithm.call(@size, value)
    # puts "ens: #{[n1, n2, n3]} #{@filter[n1]} #{@filter[n2]} #{@filter[n3]}"
    [@filter[n1], @filter[n2], @filter[n3]].reduce(1, :&)
  end

  def to_s
    @filter.to_s
  end
end

filter = BloomFilter.new(100, -> size, value {
  bits = value.to_s.bytes.to_a #.collect {|x| x % size}
  return bits[0], bits[(value.to_s.size/2).to_i], bits[value.to_s.size-1]
})

filter.add("horse")
filter.add("super")
filter.add("magic")
filter.add("pretentious")
filter.add("milkbone")
filter.add("liquidate")

def in_filter(filter, word)
  puts "#{word} exists? #{filter.exists?(word)}"
end


in_filter filter, "super"
in_filter filter, "cheese"
in_filter filter, "milk"
in_filter filter, "milkbone"
in_filter filter, "honey"

puts filter
