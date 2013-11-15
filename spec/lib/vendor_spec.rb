require 'spec_helper'

describe Vendor do
  
  let(:finder) { FarMarFinder.new }
  
  if FarMarFinder.new.respond_to? :vendors
    let(:vendor_class) { finder.vendors }
  else
    let(:vendor_class) { Vendor }
  end
  
  describe "class methods" do
    let(:sample_vendor){Vendor.new(["4", "Kris and Sons", "5", "1"])}
    it "responds to 'all'" do
      vendor_class.should respond_to :all
    end
    
    it "'all' should return" do
      vendor_class.all.count.should eq 2690
    end
    
    it "responds to 'find'" do
      vendor_class.should respond_to :find
    end
    
    it "responds to 'by_market'" do
      vendor_class.should respond_to :by_market
    end
    
    it "find the first vendor by market 1" do
      vendor_class.by_market(100).first.name.should eq "Schiller-Ledner"
    end

    it "does not throw an error" do
      vendor_class.random.should_not raise_error
    end

    it "returns the 4th vendor id when search by name 'Kris and Sons'" do
      vendor_class.find_by_name("Kris and Sons").id.should eq sample_vendor.id
    end

    it "returns the 4th vendor when searching by vendor id 4" do
      vendor_class.find_by_id(4).name.should eq sample_vendor.name
    end

    it "includes the 2nd vendor when searching for 5 employees" do
      vendor_class.find_by_no_of_employees(5).name.should eq "Hamill, Kilback and Pfeffer"
    end

    it "returns vendor 17 as 1st vendor for market 5" do
      vendor_class.by_market(5).first.id.should eq 17
    end

    it "includes Stamm Inc when searching for 2 employees" do
      vendor_class.find_all_by_no_of_employees(2).first.name.should eq "Stamm Inc"
    end

    it "returns vendor 18 for market 5" do
      vendor_class.find_all_by_market_id(5)[1].id.should eq 18
    end
  end
  
  describe "attributes" do
    let(:vendor) { vendor_class.find(10) }
    # 10,Kertzmann LLC,11,3
    
    it "has the id 10" do
      vendor.id.should eq 10
    end
    it "has the name" do
      vendor.name.should eq "Kertzmann LLC"
    end
    it "has the no of employees 11" do
      vendor.no_of_employees.should eq 11
    end
    it "has the market_id 3" do
      vendor.market_id.should eq 3
    end
  end
  
  describe "associations" do
    let(:vendor) { vendor_class.find(1) }

    it "responds to :market" do
      vendor.should respond_to :market
    end
    
    it "market_id matches the markets id" do
      vendor.market.id.should eq vendor.market_id
    end
    
    it "responds to :sales" do
      vendor.should respond_to :sales
    end
    
    it "has 7 sales" do
      vendor.sales.count.should eq 7
    end
    
    it "responds to products" do
      vendor.should respond_to :products
    end
    
    it "has 1 products" do
      vendor.products.count.should eq 1
    end
  end
  
end