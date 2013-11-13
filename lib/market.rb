class Market
  attr_reader :id, :name, :address, :city, :county, :state, :zip # etc...

  def initialize(array)
    @id = array[0].to_i
    @name = array[1]
    @address = array[2]
    @city = array[3]
    @county = array[4]
    @state = array[5]
    @zip = array[6]
  end

  def self.all
    @list ||= make_list
  end

  def self.make_list
    CSV.read("./support/markets.csv").map do |array|
      Market.new(array)
    end
  end

  def self.find(id)
    all.find do |market_instance|
      market_instance.id.to_i == id
    end
  end

  def self.find_by_name(name) #Ideas for EC: Search for impartial name
    all.find do |market_instance|
      market_instance.name.upcase == name.upcase
    end
  end

  def self.find_all_by_city(city)
    all.select do |market_instance|
      market_instance.city.upcase == city.upcase
    end
  end

  def self.find_all_by_state(state)
    all.select do |market_instance|
      market_instance.state.upcase == state.upcase
    end
  end

  def self.find_all_by_zip(zip)
    all.select do |market_instance|
      market_instance.zip.to_i == zip.to_i
    end
  end

  def self.search(search_term)
    market_list = []
    search_regex = Regexp.new(search_term.upcase)
    all.each do |market_instance|
      market_instance.to_a.each do |attribute|
        test = attribute.to_s.upcase.match search_regex
        if test.class == MatchData
          market_list << market_instance
        end 
      end
    end
    market_list
  end

  def products #Ideas for EC: Search for impartial name
    Product.by_market(@id)
  end

  def self.random #random returns a random instance
      all.sample
  end

  def vendors # returns a collection of Vendor instances that are associated with the market by the market_id field.
    Vendor.all.select do |vendor_instance|
      vendor_instance.market_id == @id
    end
  end 

  # extra methods that just help make things easier
  def to_a
    #convert to array
    [@id, @name, @address, @city, @county, @state, @zip]
  end
end