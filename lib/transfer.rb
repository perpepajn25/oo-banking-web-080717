class Transfer

  attr_accessor :status
  attr_reader :sender, :receiver, :amount

  def initialize(sender,receiver,amount)
  @status = "pending"
  @sender = sender
  @receiver = receiver
  @amount = amount
  end

  def valid?
    @sender.valid? && @receiver.valid? && @sender.sufficient(@amount) ? true : false
  end

  def execute_transaction
    if self.valid? && self.status == "pending"
      @sender.balance -= @amount
      @receiver.balance += @amount
      @status = "complete"
    else
      @status = "rejected"
      return "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if self.status == "complete" && @receiver.sufficient(@amount)
      @sender.balance += @amount
      @receiver.balance -= @amount
      @status = "reversed"
    end
  end

end
