class Product
  attr_accessor :id, :name, :vendor_id

  def initialize(array)
    @id = array[0].to_i
    @name = array[1]
    @vendor_id = array[2].to_i
  end


  def self.all
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
  
  def vendor # Returns the vendor instance associated with this product
    
  end

  def sales # Returns collection of Sale instances associated with this product
    
  end

  def number_of_sales #Returns the number of times this product has been sold
    
  end


end
