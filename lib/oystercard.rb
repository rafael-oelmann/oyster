class Oystercard
  attr_reader :balance, :entry_station, :exit_station, :journeys
  LIMIT = 90
  MIN_FARE = 1

  def initialize(balance = 0)
    @balance = balance
    @in_journey = false
    @entry_station = nil
    @exit_station = nil
    @journeys = {}
  end

  def in_journey?
    !!entry_station
  end

  def top_up(amount)
    raise "you have exeeded your max balance of #{LIMIT}" if balance + amount > LIMIT

    @balance += amount
  end

  def touch_in(entry_station)
    raise "not enough balance" if balance < MIN_FARE
    @in_journey = true
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    deduct(MIN_FARE)
    @entry_station = nil
    @exit_station = exit_station
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
