class Market
  attr_reader :id, :name, :address, :city, :county, :state, :zip # etc...

  def initialize(array)
    @id = array[0].to_i
    @name = array[1]
    @address = array[2]
    @city = array[3]
    @county = array[4]
    @state = array[5]
    @zip = array[6].to_i
  end

  def self.all
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

def self.find_all_by_name(name) #Ideas for EC: Search for impartial name
    all.select do |market_instance|
      market_instance.name.upcase == name.upcase
    end
  end

  def vendors # returns a collection of Vendor instances that are associated with the market by the market_id field.
    Vendor.all.select do |vendor_instance|
      vendor_instance.market_id == @id
    end
  end 

  #Market.new should be able to be used for each of the elements of the Market file

end