class Sale
  attr_reader :id, :value, :purchase_time, :vendor_id, :product_id
  def initialize(array)
    @id = array[0]
    @value = array[1]
    @purchase_time = array[2]
    @vendor_id = array[3]
    @product_id = array[4]
    
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
end