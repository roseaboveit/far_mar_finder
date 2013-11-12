class Vendor
  attr_reader :id, :name, :num_employees, :market_id
  def initialize(array)
    @id = array[0].to_i
    @name = array[1]
    @num_employees = array[2].to_i
    @market_id = array[3].to_i
  end


  def self.all
    CSV.read("./support/vendors.csv").map do |array|
      Vendor.new(array)
    end
  end

  def self.find(id)
    all.find do |vendor_instance|
      vendor_instance.id.to_i == id
    end
  end

  def self.find_by_name(name) #Ideas for EC: Search for impartial name
    all.find do |vendor_instance|
      vendor_instance.name.upcase == name.upcase
    end
  end

  def self.find_all_by_name(name) #Ideas for EC: Search for impartial name
    all.select do |vendor_instance|
      vendor_instance.name.upcase == name.upcase
    end
  end

  def market # returns the Market instance that is associated with this vendor using the Vendor market_id field
    Market.all.find do |market_instance|
      market_instance.id == @market_id
    end
  end 

  def products # returns a collection of Product instances that are associated with market by the Product vendor_id field.d.
    Product.all.select do |product_instance|
      product_instance.vendor_id == @id
    end
  end 

  def sales # returns a collection of Sale instances that are associated with market by the vendor_id field.
    Sale.all.select do |sale_instance|
      sale_instance.vendor_id == @id
    end
  end 

  def revenue #returns the the sum of all of the vendor's sales (in cents)
    sales_array = sales
    sum = 0
    sales_array.each do |sale|
      sum += sale.value
    end
    sum
  end
end