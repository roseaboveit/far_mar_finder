class Market
  attr_reader :name, :address # etc...

  def initialize(array)
    @name = array[1]
  end

  def self.all
    CSV.read("./support/markets.csv").map do |array|
      Market.new()
    end
  end
  #Market.new should be able to be used for each of the elements of the Market file

end