module ContactScopes
  extend ActiveSupport::Concern
  included do
    has_scope :by_first_name, as: :first_name
    has_scope :by_last_name, as: :last_name
    has_scope :by_company, as: :company
    has_scope :by_country, as: :country
    has_scope :by_state, as: :state
    has_scope :by_city, as: :city
  end
end
