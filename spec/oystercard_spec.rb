require 'oystercard'

describe Oystercard do
  context '#balance' do
    it 'when created has a balance of 0' do
      expect(subject.balance).to eq 0
    end
  end

  context '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'can top up the balance of the card' do
      expect { subject.top_up(5) }.to change { subject.balance }.by(5)
    end
  end

  context '#max limit' do
    it 'raises error :you have exeeded your max balance if over limit' do
      limit = Oystercard::LIMIT
      subject.top_up(limit)
      expect { subject.top_up(1) }.to raise_error "you have exeeded your max balance of #{limit}"
    end
  end

  context '#Deduct Money' do
    it { is_expected.to respond_to(:deduct).with(1).argument }

    it 'can deduct money from the balance of the card' do
      expect { subject.deduct(5) }.to change { subject.balance }.by(-5)
    end
  end

  context '#Journey status' do 
    it 'user will initlialize "not in journey"' do 
      expect(subject.in_journey).to eq false 
    end
  end
  context '#Touching in/out' do 
  
    it { is_expected.to respond_to :touch_in }

    it 'touching in will change status of in_journey to true' do 
      expect { subject.touch_in }.to change { subject.in_journey }.to true
    end

    it 'touching out in will change status of in_journey to false' do 
      subject.touch_in
      expect {subject.touch_out }.to change { subject.in_journey}.to false
    end

    it 'will raise an error if user touches out whilst not in journey' do 
      
      expect { subject.touch_out}.to raise_error "not in journey"
      
    end
  end
end
