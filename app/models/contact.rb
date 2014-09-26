class Contact < ActiveRecord::Base
  acts_as_commentable
  
  has_many :events, foreign_key: 'host_id'
  has_many :children, dependent: :destroy

  validates_presence_of :first_name, :last_name
  validates_uniqueness_of :email, allow_blank: true
  
  # Scope methods
  scope :by_first_name, -> first_name { where("first_name like ?", "%#{first_name}%") }
  scope :by_last_name, -> last_name { where("last_name like ?", "%#{last_name}%") }
  scope :by_email, -> email { where(first_name: email) }
  scope :by_company, -> company { where(company: company) }
  scope :by_country, -> country { where(country: country) }
  scope :by_state, -> state { where(state: state) }
  scope :by_city, -> city { where(city: city) }
  # scope :active, -> where { where(active: true) }

  GENDER = %w[Boy Girl]
  RELATIONSHIP = %w[Son/Daughter Grandson/Granddaughter Niece/Nephew Other]
  
  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |contact|
        csv << contact.attributes.values_at(*column_names)
      end
    end
  end

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

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def as_json(options = {})
    return {
      id:         id.to_s,
      name:       full_name,
      firstName:  first_name,
      lastName:   last_name,
      city:       city,
      state:      state,
      country:    country,
      updatedAt:  updated_at.to_i,
      createdAt:  created_at.to_i
    }
  end

end
