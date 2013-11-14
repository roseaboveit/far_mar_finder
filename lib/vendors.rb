class Vendor
  attr_reader :id, :name, :no_of_employees, :market_id, :revenue
  def initialize(array)
    @id = array[0].to_i
    @name = array[1]
    @no_of_employees = array[2].to_i
    @market_id = array[3].to_i
    @revenue = revenue
  end

  def self.all
    @list ||= make_list
  end

  def self.make_list
    CSV.read("./support/vendors.csv").map do |array|
      Vendor.new(array)
    end
  end

  def self.find(id)
    all.find do |vendor_instance|
      vendor_instance.id.to_i == id
    end
  end

  def self.find_by_id(id) 
    all.find do |vendor_instance|
      vendor_instance.id.to_i== id.to_i
    end
  end

  def self.find_by_name(name) 
    all.find do |vendor_instance|
      vendor_instance.name.upcase == name.upcase
    end
  end

  def self.find_by_no_of_employees(no_of_employees) 
    all.find do |vendor_instance|
      vendor_instance.no_of_employees.to_i == no_of_employees.to_i
    end
  end

  def self.by_market(market_id)
    all.select do |vendor_instance|
      vendor_instance.market_id == market_id
    end
  end

  def self.find_all_by_no_of_employees(no_of_employees) 
    all.select do |vendor_instance|
      vendor_instance.no_of_employees.to_i == no_of_employees.to_i
    end
  end

  def self.find_all_by_market_id(market_id) 
    all.select do |vendor_instance|
      vendor_instance.market_id.to_i == market_id.to_i
    end
  end

  def self.random #random returns a random instance
    all.sample
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
      sum += sale.amount
    end
    sum
  end

  def no_of_products
    sum = 0
    products.each do |element| 
      sum += 1  
    end
    sum
  end
end