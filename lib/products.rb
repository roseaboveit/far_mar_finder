class Product
  attr_accessor :id, :name, :vendor_id

  def initialize(array)
    @id = array[0].to_i
    @name = array[1]
    @vendor_id = array[2].to_i
  end

  def self.all
    @list ||= make_list
  end

  def self.make_list
    CSV.read("./support/products.csv").map do |array|
      Product.new(array)
    end
  end

  def self.find(id)
    all.find do |product_instance|
      product_instance.id.to_i == id
    end
  end

  def self.find_by_name(name) #Ideas for EC: Search for impartial name
    all.find do |product_instance|
      product_instance.name.upcase == name.upcase
    end
  end

  def self.by_vendor(vendor_id)
    all.select do |product_instance|
      product_instance.vendor_id == vendor_id
    end
  end
  
  def self.by_market(market_id) #Ideas for EC: Search for impartial name
      vendor_list = Vendor.by_market(market_id) 
      product_list = []
      vendor_list.each do |vendor_object|
         product_list = all.select do |product_instance|
         product_instance.vendor_id.to_i == vendor_object.id.to_i
       end
      end
      product_list
  end

  def self.find_all_by_name(name) #Ideas for EC: Search for impartial name
    all.select do |product_instance|
      product_instance.name.upcase == name.upcase
    end
  end

  def self.find_all_by_vendor_id(vendor_id) #Ideas for EC: Search for impartial name
    all.select do |product_instance|
      product_instance.vendor_id.to_i == vendor_id.to_i
    end
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
