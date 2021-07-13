
class Player < ActiveRecord::Base
  has_many :tickets
  has_many :tournaments, through: :tickets

  # Existing Method from another project
  def full_name
    "#{self.first_name} #{self.last_name}"
  end

end
