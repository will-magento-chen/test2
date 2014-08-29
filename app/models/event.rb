class Event < ActiveRecord::Base
  belongs_to :event_type
  before_create :generate_affiliate_code

  belongs_to :host, foreign_key: 'host_id', class_name: 'Contact'

  scope :active, -> { where("STR_TO_DATE(CONCAT(end_date, ' ', end_time), '%Y-%m-%d %H:%i') > ?", Time.now) }
  scope :past, -> { where("STR_TO_DATE(CONCAT(end_date, ' ', end_time), '%Y-%m-%d %H:%i') < ?", Time.now) }
  
  def full_address
    country = Carmen::Country.coded(self.country)
    if country.nil?
      country = self.country
    else
      if country.subregions?
        state = country.subregions.coded(self.state).try(:name)
      end
      country = country.name
    end

    state ||= self.state
    "#{self.city}, #{state}, #{country}"
  end

  protected

  def generate_affiliate_code
    self.affiliate_code = loop do
      code = Faker::Code.isbn
      break code unless Event.exists?(affiliate_code: code)
    end
  end
end
