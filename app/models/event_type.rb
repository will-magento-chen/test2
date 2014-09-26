class EventType < ActiveRecord::Base
  has_many :events

  def as_json(options = {})
    return {
      id:         id.to_s,
      name:       name,
      updatedAt:  updated_at.to_i,
      createdAt:  created_at.to_i
    }
  end
end
