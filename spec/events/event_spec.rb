# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'event spec' do
    it 'requires a datetime' do
      event = Event.new(event_type: 'Training', location: 'Stadium')
      expect(event).not_to be_valid
      expect(event.errors[:datetime]).to include("can't be blank")
    end

    it 'requires an event_type' do
      event = Event.new(datetime: 1.day.from_now, location: 'Stadium')
      expect(event).not_to be_valid
      expect(event.errors[:event_type]).to include("can't be blank")
    end
  end

  describe 'creating a valid event' do
    it 'saves successfully with valid attributes' do
      event = Event.new(datetime: 1.day.from_now, event_type: 'Training', location: 'Stadium', notes: 'Bring boots')
      expect(event).to be_valid
      expect(event.save).to be true
    end
  end
end
