class Contact < ActiveRecord::Base
  has_many :hosts, foreign_key: 'host_id'

  def full_address
    "#{self.city}, #{self.state}, #{self.country}"
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end
end
