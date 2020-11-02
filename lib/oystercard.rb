class Oystercard
  attr_reader :balance
  LIMIT = 90

  def initialize
    @balance = 0
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end

  def top_up(amount)
    raise "you have exeeded your max balance of #{LIMIT}" if balance + amount > LIMIT

    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    @in_journey = true
  end

  def touch_out
    # raise 'not in journey' if @in_journey == false

    @in_journey = false
  end
end
