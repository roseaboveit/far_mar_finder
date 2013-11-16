class Product
  attr_accessor :id, :name, :vendor_id

  def initialize(array)
    @id = array[0].to_i
    @name = array[1]
    @vendor_id = array[2].to_i
  end

  def self.all # Returns an array of all the product objects - memoized
    @list ||= make_list
  end

  def self.make_list # Finds all the product objects by going through the csv
    CSV.read("./support/products.csv").map do |array|
      Product.new(array)
    end
  end

  def self.find(id) # Finds the product with the given vendor id
    all.find do |product_instance|
      product_instance.id.to_i == id
    end
  end

  def self.find_by_name(name) # Finds the first product with a given name
    all.find do |product_instance|
      product_instance.name.upcase == name.upcase
    end
  end

  def self.by_vendor(vendor_id) # Finds the products of a given vendor by vendor id
    all.select do |product_instance|
      product_instance.vendor_id == vendor_id
    end
  end
  
  def self.by_market(market_id) # Returns all the products by a given market id
      vendor_list = Vendor.by_market(market_id) 
      product_list = []
      vendor_list.each do |vendor_object|
          all.select do |product_instance|
            if product_instance.vendor_id.to_i == vendor_object.id.to_i
              product_list<<product_instance
            end
       end
      end
      product_list
  end

  def self.find_all_by_name(name) # Returns all the products by a given name
    all.select do |product_instance|
      product_instance.name.upcase == name.upcase
    end
  end

  def self.find_all_by_vendor_id(vendor_id) # Returns all the products of a given vendor by vendor id
    all.select do |product_instance|
      product_instance.vendor_id.to_i == vendor_id.to_i
    end
  end

  def self.random #random returns a random instance
      all.sample
  end
  
  def vendor # Returns the vendor instance associated with this product's vendor_id
    Vendor.all.find do |vendor_instance|
      vendor_instance.id == @vendor_id
    end  
  end

  def sales # Returns collection of Sale instances associated with this Sale's product_id
    Sale.all.select do |sale_instance|
      sale_instance.product_id == @id
    end
  end

  def number_of_sales #Returns the number of times this product has been sold
    array_of_sales = sales
    sum = 0
    array_of_sales.each do |sale|
      sum += 1
    end
    sum
  end
end
