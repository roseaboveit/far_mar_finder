require 'csv'
require 'time'
require_relative 'sales'
require_relative 'vendors'
require_relative 'products'
require_relative 'market'
# ... Require all of the supporting classes

class FarMarFinder
  # Your code goes here
  def markets
    Market
  end

  def vendors
    Vendor 
  end

  def products
    Product
  end

  def sales
    Sale
  end
end

# Market.find(1)