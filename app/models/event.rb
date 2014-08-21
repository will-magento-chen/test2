class Event < ActiveRecord::Base
  belongs_to :event_type
  before_create :generate_affiliate_code

  belongs_to :host, foreign_key: 'host', class_name: 'Contact'

  def full_address
    "#{self.city}, #{self.state}, #{self.country}"
  end
  
  protected

  def generate_affiliate_code
    self.affiliate_code = loop do
      code = Faker::Code.isbn
      break code unless Event.exists?(affiliate_code: code)
    end
  end
end
