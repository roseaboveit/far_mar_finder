require 'spec_helper'
describe Market do
  
  let(:finder) { FarMarFinder.new }
  
  if FarMarFinder.new.respond_to? :markets
    let(:market_class) { finder.markets }
  else
    let(:market_class) { Market }
  end
  
  describe "class methods" do
    let(:sample_market) {Market.new(["5", "Quincy Farmers Market", 
      "0 Denis Ryan Parkway", "Quincy", "Norfolk", "Massachusetts", "2169"])}
    it "responds to 'all'" do
      market_class.should respond_to :all
    end
    
    it "'all' should return" do
      market_class.all.count.should eq 500
    end
    
    it "responds to 'find'" do
      market_class.should respond_to :find
    end


    it "returns the market by name" do 
      market_class.find_by_name("Quincy Farmers Market").address.should eq sample_market.address
    end

    it "by 'Quincy' returns array including market 5" do
      market_class.find_all_by_city("Quincy").first.id.should eq 5
    end

    it "by 'Massachusetts' returns array including market 5" do
      market_class.find_all_by_state("Massachusetts").first.id.should eq 5
    end

    it "by zip '2169' returns array including market 5" do
      market_class.find_all_by_zip("2169").first.id.should eq 5
    end

    it "searches 'helmer' and finds market 3" do
      market_class.search('helmer').first.id.should eq 3
    end

    it "does not throw an error" do
      market_class.random.should_not raise_error
    end

  end
  
  describe "attributes" do
    let(:market) { market_class.find(1) }
    # 1,People's Co-op Farmers Market,30,Portland,Multnomah,Oregon,97202
    
    it "has the id 1" do
      expect(market.id).to eq 1
    end

    it "has the name 'People's Co-op Farmers Market'" do
      expect(market.name).to eq "People's Co-op Farmers Market"
    end

    it "has the address '30th and Burnside'" do
      expect(market.address).to eq "30th and Burnside"
    end

    it "has the city 'Portland'" do
      expect(market.city).to eq "Portland"
    end
    it "has the county 'Multnomah'" do
      expect(market.county).to eq "Multnomah"
    end
    it "has the state 'Oregon'" do
      expect(market.state).to eq "Oregon"
    end
    it "has the zip '97202'" do
      expect(market.zip).to eq "97202"
    end
    
  end
  
  describe "instance methods" do
    let(:market) { market_class.find(1) }
    it "responds to vendors" do
      Market.new({}).should respond_to :vendors
    end
    
    it "finds the vendors" do
      market.vendors.first.id.should eq 1
    end
  end
end
