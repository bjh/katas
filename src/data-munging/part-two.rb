class DataSet
  Team = 1
  For = 6
  Against = 7
  
  def initialize(datafile)
    @data = prepare_data_file(datafile)
  end
  
  def smallest_spread
    result = 4000
    team = "nobody"
    
    @data.each_line do |line|
      if data = parse_line(line)
        spread = calculate_spread(data[For], data[Against])
        
        if spread < result
          team = data[Team]
          result = spread
        end
      end
    end
    
    team
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
  
  def prepare_data_file(datafile)
    path = File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'data', datafile))
    file = File.open(path, 'r').read()
    file = file.scan(/(?<=\<pre\>).+?(?=\<\/pre\>)/m)[0].split("\n")
    
    # http://stackoverflow.com/a/1470022
    file = file.to_a[2..-1].join("\n")

    file
  end
end


puts DataSet.new("football.dat").smallest_spread