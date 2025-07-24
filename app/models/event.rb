class Event < ApplicationRecord
  validates :datetime, presence: true
  validates :event_type, presence: true
  validates :location, presence: true

  def match?
    event_type == "match"
  end

  def training?
    event_type == "training"
  end

  def special_event?
    event_type == "special event"
  end

  def upcoming?
    datetime > Time.current
  end

  def past?
    datetime < Time.current
  end
end
