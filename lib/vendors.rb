class Vendor
  attr_reader :id, :name, :num_employees, :market_id
  def initialize(array)
    @id = array[0]
    @name = array[1]
    @num_employees = array[2]
    @market_id = array[3]
  end


  def self.all
    CSV.read("./support/vendors.csv").map do |array|
      Vendor.new()
    end
end