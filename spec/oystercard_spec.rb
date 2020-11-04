require 'oystercard'

describe Oystercard do

  context '#Initialized Card' do
    it 'when created has a balance of 0' do
      expect(subject.balance).to eq 0
    end

    it 'when created has an empty list of journeys' do
      expect(subject.journeys).to be_empty
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

  context '#Journey status' do
    it 'user will initlialize "not in journey"' do
      expect(subject).not_to be_in_journey
    end
  end

  context '#Touching in/out' do

    let(:entry_station) { double :entry_station }
    let(:exit_station) { double :exit_station }
    let(:topped_up_card) { Oystercard.new(5)} 
    let(:card_in_journey) { Oystercard.new(5).touch_in(entry_station) }
    

    it { is_expected.to respond_to :touch_in }

    it 'will raise an error if user touches in without money in balance' do
      expect { subject.touch_in(entry_station) }.to raise_error "not enough balance"
    end

    it 'touching in will change status of in_journey to true' do
      topped_up_card.touch_in(entry_station)
      expect(topped_up_card).to be_in_journey
    end

    it 'touching out in will change status of in_journey to false' do
      topped_up_card.touch_out(exit_station)
      expect(topped_up_card).not_to be_in_journey
    end

    it 'will charge minimum fare deducting it from balance' do
      expect { topped_up_card.touch_out(exit_station) }.to change { topped_up_card.balance }.by(-Oystercard::MIN_FARE)
    end

    it 'stores the entry station' do 
      expect(card_in_journey).to eq entry_station  
    end

    it 'stores the exit_station' do 
      topped_up_card.touch_in(entry_station)
      topped_up_card.touch_out(exit_station)
      expect(topped_up_card.exit_station).to eq exit_station
    end

  end
end
