class Sale
  attr_reader :id, :amount, :purchase_time, :vendor_id, :product_id
  def initialize(array)
    @id = array[0].to_i
    @amount = array[1].to_i
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

  def self.find_by_amount(value_in_cents) #Ideas for EC: Search for date
    all.find do |sales_instance|
      sales_instance.amount == value_in_cents
    end
  end

  def self.find_all_by_amount(value_in_cents) #Ideas for EC: Search for date
    all.select do |sales_instance|
      sales_instance.amount == value_in_cents
    end
  end

  def self.find_all_by_purchase_time(purchase_time) #Ideas for EC: Search for date
    all.select do |sales_instance|
      sales_instance.purchase_time == Time.parse(purchase_time)
    end
  end

  def self.between(beginning_time, end_time) # Returns Sale objects in given range
    start = Time.parse(beginning_time)
    finish = Time.parse(end_time)

    all.select do |sales_instance|
      sales_instance.purchase_time <= finish && sales_instance.purchase_time >= start
    end
  end 

  def self.average_price
    sum = 0
    sales_qty = 0
    all.each do |sale_instance|
      sum += sale_instance.amount.to_i
      sales_qty += 1
    end
    sum/sales_qty
  end


  def vendor # Returns Vendor instance associated with the sale
    Vendor.find(@vendor_id)
  end 

  def product # Returns the Product instance associated with the sale
    Product.find(@product_id)
  end 
end