class Contact < ActiveRecord::Base

  def full_address
    "#{self.city}, #{self.state}, #{self.country}"
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end
end
