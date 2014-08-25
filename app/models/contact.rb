class Contact < ActiveRecord::Base
  has_many :hosts, foreign_key: 'host_id'
  has_many :children, dependent: :destroy

  accepts_nested_attributes_for :children, allow_destroy: true

  validates_presence_of :first_name, :last_name, :children

  # Scope methods
  scope :by_first_name, -> first_name { where("first_name like ?", "%#{first_name}%") }
  scope :by_last_name, -> last_name { where("last_name like ?", "%#{last_name}%") }
  scope :by_email, -> email { where(first_name: email) }
  scope :by_company, -> company { where(company: company) }
  scope :by_country, -> country { where(country: country) }
  scope :by_state, -> state { where(state: state) }
  scope :by_city, -> city { where(city: city) }
  # scope :active, -> where { where(active: true) }

  def full_address
    "#{self.city}, #{self.state}, #{self.country}"
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end
end
