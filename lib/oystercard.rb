class Oystercard
  attr_reader :balance, :entry_station
  LIMIT = 90
  MIN_FARE = 1

  def initialize(balance = 0)
    @balance = balance
    @in_journey = false
    @entry_station = nil
  end

  def in_journey?
    !!entry_station
  end

  def top_up(amount)
    raise "you have exeeded your max balance of #{LIMIT}" if balance + amount > LIMIT

    @balance += amount
  end

  def touch_in(station)
    raise "not enough balance" if balance < MIN_FARE
    @in_journey = true
    @entry_station = station
  end

  def touch_out
    deduct(MIN_FARE)
    @entry_station = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
