class Base
  protected
  
  def initialize(datafile, range)
    @data = prepare_data_file(datafile, range)
  end
  
  def smallest_spread(name, low, high)
    result = 4000
    answer = nil
    
    @data.each_line do |line|
      if data = parse_line(line)
        spread = calculate_spread(data[low], data[high])
        
        if spread < result
          answer = data[name]
          result = spread
        end
      end
    end
    
    answer
  end
    
  private
  
  def calculate_spread(low, high)
    (high.to_i - low.to_i).abs
  end
  
  def parse_line(line)
    line = line.lstrip.strip
    return nil if line.start_with? '-'
    line = line.gsub('-', '')
    line.split(/\s+/)
  end
  
  def prepare_data_file(datafile, range)
    path = File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'data', datafile))
    file = File.open(path, 'r').read()
    file = file.scan(/(?<=\<pre\>).+?(?=\<\/pre\>)/m)[0].split("\n")
    
    # http://stackoverflow.com/a/1470022
    file = file.to_a[range].join("\n")

    file
  end
end


class Weather < Base
  def initialize
    super("weather.dat", 5..-2)
  end
  
  def run
    puts smallest_spread(0, 2, 1)
  end
end

class Football < Base
  def initialize
    super("football.dat", 2..-1)
  end
  
  def run
    puts smallest_spread(1, 6, 7)
  end
end


Weather.new.run
Football.new.run