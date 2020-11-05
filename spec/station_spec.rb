require 'station'

describe Station do 
  station = Station.new('Walthamstow', 3)

  it "initializes with a name" do 
    expect(station.name).to eq 'Walthamstow'
  end

  it "initializes with a zone" do 
    expect(station.zone).to eq 3    
  end

end
