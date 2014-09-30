class Event < ActiveRecord::Base
  acts_as_commentable
  
  belongs_to :event_type
  belongs_to :host, foreign_key: 'host_id', class_name: 'Contact'

  before_create :generate_affiliate_code

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

  def as_json(options = {})
    return {
      id:         id.to_s,
      name:       name,
      eventType:  event_type,
      host:       host,
      affiliateCode: affiliate_code,
      updatedAt:  updated_at.to_i,
      createdAt:  created_at.to_i
    }
  end

  protected

  def generate_affiliate_code
    self.affiliate_code = loop do
      code = Faker::Code.isbn
      break code unless Event.exists?(affiliate_code: code)
    end
  end
end
