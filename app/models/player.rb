
class Player < ActiveRecord::Base
  has_many :tickets
  has_many :tournaments, through: :tickets

  # Existing Method from another project
  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def deposit(amount)
    self.account_balance += amount
  end

  def withdraw(amount)
    self.account_balance -= amount
  end

end
