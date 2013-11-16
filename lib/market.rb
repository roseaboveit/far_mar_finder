class Market
  attr_reader :id, :name, :address, :city, :county, :state, :zip # etc...

  def initialize(array)
    @id = array[0].to_i
    @name = array[1]
    @address = array[2]
    @city = array[3]
    @county = array[4]
    @state = array[5]
    @zip = array[6]
  end

# Class methods

  def self.all # Returns an Array of all the markets - memoized
    @list ||= make_list
  end

  def self.make_list # Finds all the market objects by going through the csv
    CSV.read("./support/markets.csv").map do |array|
      Market.new(array)
    end
  end

  def self.find(id) # Finds the market instance by passing in the id
    all.find do |market_instance|
      market_instance.id.to_i == id
    end
  end

  def self.find_by_name(name) # Finds the first market instance with the passed in name
    all.find do |market_instance|
      market_instance.name.upcase == name.upcase
    end
  end

  def self.find_all_by_city(city) # Finds all the market instances for a given city
    all.select do |market_instance|
      unless market_instance.city == nil
        market_instance.city.upcase == city.upcase
      else
        market_instance.city == city
      end
      
    end
  end

  def self.find_all_by_state(state) # Finds all the market instances for a given state
    all.select do |market_instance|
      unless state == nil
        market_instance.state.upcase == state.upcase
      else 
        market_instance.state == state
      end
    end
  end

  def self.find_all_by_zip(zip) # Finds all the market instances for a given zip code
    all.select do |market_instance|
      market_instance.zip.to_i == zip.to_i
    end
  end

  def self.search(search_term) # Finds all the market instances that include the given search term
    market_list = []
    search_regex = Regexp.new(search_term.upcase) # This method disregards case
    all.each do |market_instance|
      market_instance.to_a.each do |attribute|
        test = attribute.to_s.upcase.match search_regex # The class returned is MatchData if there is a match
        if test.class == MatchData
          market_list << market_instance
        end 
      end
    end
    market_list
  end

# Start of instance methods

  def self.random #random returns a random instance
      all.sample
  end

  def products # Returns all the products in the market by the market_id field
    Product.by_market(@id)
  end

  def vendors # returns all the vendor in the market by the market_id field
    Vendor.all.select do |vendor_instance|
      vendor_instance.market_id == @id
    end
  end 

  def preferred_vendor(date=nil) # returns the vendor with the best sales 
    if date == nil # uses the best_vendor method if the user does not pass a date
      best_vendor
    else # uses the best_vendor_by_date method if the user does pass a date
      best_vendor_by_date(date)
    end
  end
  
  def best_vendor # returns the vendor with biggest revenue of all recorded time
    best_vendor = 0
    vendors_revenue = []
    vendors.each do |vendor_instance|
      vendors_revenue << vendor_instance.revenue
      if vendor_instance.revenue == vendors_revenue.max
        best_vendor = vendor_instance
      end
    end
    best_vendor
  end

  def worst_vendor # returns the vendor with the smallest revenue of all recorded time
    worst_vendor = 0
    vendors_revenue = []
    vendors.each do |vendor_instance|
      vendors_revenue << vendor_instance.revenue
      if vendor_instance.revenue == vendors_revenue.min
        worst_vendor = vendor_instance
      end
    end
    worst_vendor
  end

  def best_vendor_by_date(date) # returns the vendor with the biggest revenue on a specific date
    relevant_date = Time.parse(date) 
    relevant_sales = []
    sales_array = Sale.specific_date(relevant_date)
    vendors.each do |vendor_instance|
      sales_array.each do |sales_instance|
        if sales_instance.vendor_id == vendor_instance.id
          relevant_sales << sales_instance
        end # By this point the method has constructed an array of relevant sales.
      end
    end
    best_vendor_id = 0
    best_vendor_revenue = 0 
    vendors_revenue = {}
    relevant_sales.each do |sales_instance|
      key = sales_instance.vendor_id
      unless vendors_revenue.has_key?(sales_instance.vendor_id)
        vendors_revenue[key] = 0
      end
      vendors_revenue[key] += sales_instance.amount
    end # By this point the vendors_revenue should have keys that are vendor ids and values are revenue
    
    vendors_revenue.each do |key,value| 
      if value >= best_vendor_revenue
        best_vendor_id = key
        best_vendor_revenue = value
      end
    end # By this point the best vendor has been identified 
    Vendor.find(best_vendor_id) # Returns the Vendor object associated with the best vendor id
  end

  # extra methods that just help make things easier
  def to_a
    #convert to array
    [@id, @name, @address, @city, @county, @state, @zip]
  end
end