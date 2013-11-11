class Product
  attr_accessor :id, :name, :vendor_id

  def initialize(array)
    @id = array[0]
    @name = array[1]
    @vendor_id = array[2]
  end
  

end
