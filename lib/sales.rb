class Sale
  attr_reader :id, :amount, :purchase_time, :vendor_id, :product_id
  def initialize(array)
    @id = array[0].to_i
    @amount = array[1].to_i
    @purchase_time = Time.parse(array[2])
    @vendor_id = array[3].to_i
    @product_id = array[4].to_i
  end

# Class Methods

  def self.all # Returns an array of all the sale objects - memoized
    @list ||= make_list
  end

  def self.make_list # Finds all the sale objects by going through the csv
    CSV.read("./support/sales.csv").map do |array|
      Sale.new(array)
    end
  end

  def self.find(id) # Returns the sale with a given sale id
    all.find do |sale_instance|
      sale_instance.id.to_i == id
    end
  end

  def self.find_by_amount(value_in_cents) # Returns the first Sale with a given sale price
    all.find do |sales_instance|
      sales_instance.amount == value_in_cents
    end
  end

  def self.find_all_by_amount(value_in_cents) # Returns an array with all sales of same sale price
    all.select do |sales_instance|
      sales_instance.amount == value_in_cents
    end
  end

  def self.find_all_by_purchase_time(purchase_time) # Returns an array of all with same purchase time
    all.select do |sales_instance|
      sales_instance.purchase_time == Time.parse(purchase_time)
    end
  end

  def self.between(beginning_time, end_time) # Returns all Sale objects in given time range
    start = Time.parse(beginning_time)
    finish = Time.parse(end_time)

    all.select do |sales_instance|
      sales_instance.purchase_time <= finish && sales_instance.purchase_time >= start
    end
  end 

  def self.specific_date(time_object) #Returns an Array of all the sales on a given date
    all.select do |sales_instance|
      sales_instance.purchase_time.yday == time_object.yday
    end
  end

  def self.average_price # Returns the average price of all the sales
    sum = 0
    sales_qty = 0
    all.each do |sale_instance|
      sum += sale_instance.amount.to_i
      sales_qty += 1
    end
    sum/sales_qty
  end

  def self.random #random returns a random instance
      all.sample
  end

# Instance Methods

  def vendor # Returns Vendor instance associated with the sale
    Vendor.find(@vendor_id)
  end 

  def product # Returns the Product instance associated with the sale
    Product.find(@product_id)
  end 
end