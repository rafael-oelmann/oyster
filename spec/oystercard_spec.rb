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
end
