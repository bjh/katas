class DataSet
  Day = 0
  MaxTemp = 1
  MinTemp = 2
  
  def initialize(datafile)
    @data = prepare_data_file(datafile)
  end
  
  def smallest_spread
    result = 10000
    day = 0
    
    @data.each_line do |line|
      data = parse_line(line)
      spread = calculate_spread(data[MinTemp], data[MaxTemp])
      
      if spread < result
        day = data[Day]
        result = spread
      end
    end
    
    day
  end
    
  private
  
  def calculate_spread(low, high)
    high.to_i - low.to_i
  end
  
  def parse_line(line)
    line.lstrip.strip.split(/\s+/)
  end
  
  def prepare_data_file(datafile)
    path = File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'data', datafile))
    file = File.open(path, 'r').read()
    file = file.scan(/(?<=\<pre\>).+?(?=\<\/pre\>)/m)[0].split("\n")
    
    # http://stackoverflow.com/a/1470022
    file = file.to_a[5..-2].join("\n")

    file
  end
end


puts DataSet.new("weather.dat").smallest_spread