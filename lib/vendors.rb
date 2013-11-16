class Vendor
  attr_reader :id, :name, :no_of_employees, :market_id
  def initialize(array)
    @id = array[0].to_i
    @name = array[1]
    @no_of_employees = array[2].to_i
    @market_id = array[3].to_i
  end

  def self.all # Returns an array of all the vendor objects - memoized
    @list ||= make_list
  end

  def self.make_list # Finds all the vendor objects by going through the csv
    CSV.read("./support/vendors.csv").map do |array|
      Vendor.new(array)
    end
  end

  def self.find(id) # Returns a vendor object based on the id number
    all.find do |vendor_instance|
      vendor_instance.id.to_i == id
    end
  end

  def self.find_by_id(id) # Returns a vendor object with a given vendor id
    all.find do |vendor_instance|
      vendor_instance.id.to_i== id.to_i
    end
  end

  def self.find_by_name(name) # Returns the first vendor with a given name
    all.find do |vendor_instance|
      vendor_instance.name.upcase == name.upcase
    end
  end

  def self.find_by_no_of_employees(no_of_employees) # Returns the first vendor with a given number of employees
    all.find do |vendor_instance|
      vendor_instance.no_of_employees.to_i == no_of_employees.to_i
    end
  end

  def self.by_market(market_id) # returns all the vendors with a given market id
    all.select do |vendor_instance|
      vendor_instance.market_id == market_id
    end
  end

  def self.find_all_by_no_of_employees(no_of_employees) # returns all vendors with given number of vendors
    all.select do |vendor_instance|
      vendor_instance.no_of_employees.to_i == no_of_employees.to_i
    end
  end

  def self.find_all_by_market_id(market_id) # returns all the vendors with a given market id
    all.select do |vendor_instance|
      vendor_instance.market_id.to_i == market_id.to_i
    end
  end

  def self.random #random returns a random instance
    all.sample
  end

  def self.most_revenue(n)#returns the top n vendor instances ranked by total revenue
    vendor_revenues = {}
    all.each do |vendor_instance|
      vendor_revenues[vendor_instance] = vendor_instance.revenue
    end
    vendor_revenues.sort_by {|key, value| value}[0,n].collect {|k_v| k_v[0]} 
  end

# Instance Methods

  def market # returns the Market instance using the Vendor market_id field
    Market.all.find do |market_instance|
      market_instance.id == @market_id
    end
  end 

  def products # returns a collection of Product instances by the vendor_id field.
    Product.all.select do |product_instance|
      product_instance.vendor_id == @id
    end
  end 

  def sales # returns a collection of Sale instances by the vendor_id field.
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

  def no_of_products # returns the number of products that the vendor sells
    sum = 0
    products.each do |element| 
      sum += 1  
    end
    sum
  end
end