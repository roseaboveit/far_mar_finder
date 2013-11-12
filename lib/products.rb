class Product
  attr_accessor :id, :name, :vendor_id

  def initialize(array)
    @id = array[0]
    @name = array[1]
    @vendor_id = array[2]
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
  

end
