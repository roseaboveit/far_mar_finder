class Sale
  attr_reader :id, :value, :purchase_time, :vendor_id, :product_id
  def initialize(array)
    @id = array[0].to_i
    @value = array[1].to_i
    @purchase_time = Time.parse(array[2])
    @vendor_id = array[3].to_i
    @product_id = array[4].to_i
    
  end


  def self.all
    CSV.read("./support/sales.csv").map do |array|
      Sale.new(array)
    end
  end

  def self.find(id)
    all.find do |sale_instance|
      sale_instance.id.to_i == id
    end
  end

  def self.find_by_name(value_in_cents) #Ideas for EC: Search for date
    all.find do |sales_instance|
      sales_instance.value == value_in_cents
    end
  end

  def self.find_all_by_name(value_in_cents) #Ideas for EC: Search for date
    all.select do |sales_instance|
      sales_instance.value == value_in_cents
    end
  end

  def self.between(beginning_time, end_time) # Returns Sale objects in given range
    start = Time.parse(beginning_time)
    finish = Time.parse(end_time)

    all.select do |sales_instance|
      sales_instance.purchase_time <= finish && sales_instance.purchase_time >= start
    end
  end #Doesn't work yet!

  def vendor # Returns Vendor instance associated with the sale
    Vendor.find(@vendor_id)
  end #Doesn't work yet!

  def product # Returns the Product instance associated with the sale
    Product.find(@product_id)
  end #Doesn't work yet!
end