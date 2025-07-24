# frozen_string_literal: true

FINNISH_FIRST_NAMES = %w[
  Aino Aleksi Anni Arttu Eevi Elias Emma Eetu
  Helmi Hugo Iida Jere Kalle Leevi Lilja Matias
  Milla Sausage Niko Oona Onni Pinja Roni Saga Samu
  Siiri Tuomas Veera Ville Aada Aapo
].freeze

FINNISH_LAST_NAMES = %w[
  Korhonen Virtanen Makinen Nieminen Makela Hamalanen
  Laine Heikkinen Koskinen Jarvinen Lehtonen Saarinen
  Salminen Heinonen Niemi Sausage Heikkila Kinnunen Salonen
  Turunen Salo Laitinen Tuomi Takala Hanninen
  Kallio Rautiainen Hakkarainen Metsala Laakso Rantanen
].freeze

FINNISH_CITIES = %w[
  Helsinki Espoo Tampere Vantaa Oulu Turku Jyvaskyla
  Lahti Kuopio Pori Joensuu Lappeenranta Hameenlinna
  Vaasa Seinajoki Rovaniemi Mikkeli Kotka Salo Porvoo
].freeze

POSITIONS = [
  'Forward', 'Midfielder', 'Defender', 'Goalkeeper', 'Striker', 'Winger',
  'Centre-back', 'Full-back', 'Attacking midfielder', 'Defensive midfielder'
].freeze

unless User.exists?(username: 'Admin')
  User.create(access_level: 'admin', username: 'Admin/Club', email: 'admin@example.com',
              password: 'admin123', password_confirmation: 'admin123', balence: '500')
  User.create(access_level: 'player', username: 'Terry Player', email: 'user@example.com',
              password: 'user123', password_confirmation: 'user123', balence: '-100')
end

if User.where(access_level: 'player').count < 100
  99.times do |_i|
    first_name = FINNISH_FIRST_NAMES.sample
    last_name = FINNISH_LAST_NAMES.sample
    username = "#{first_name.downcase} #{last_name.downcase}"
    email = "#{first_name.downcase}_#{last_name.downcase}#{rand(0..99)}@example.com"
    counter = 1
    original_username = username
    while User.exists?(username: username)
      username = "#{original_username}#{counter}"
      counter += 1
    end

    User.create!(
      username: username,
      email: email,
      password: 'password123',
      password_confirmation: 'password123',
      access_level: 'player',
      position: POSITIONS.sample,
      chain: [1, 2, 3].sample.to_s,
      car: [true, false].sample,
      location: FINNISH_CITIES.sample
    )
  end

  EVENT_TYPES = ['match', 'training', 'special event'].freeze
  EVENT_LOCATIONS = FINNISH_CITIES + ['Main Stadium', 'Training Facility', 'Community Hall', 'Local Sports Park']
  EVENT_NOTES = {
    'match' => [
      'Crucial league match.', 'Friendly game to test new tactics.', 'Cup tournament first round.',
      'Pre-season warm-up.', 'Charity match for a local cause.'
    ],
    'training' => [
      'Focus on defensive formations.', 'Shooting and finishing drills.', 'Cardio and endurance session.',
      'Set-piece practice (corners and free-kicks).', 'Tactical walkthrough for the next game.'
    ],
    'special event' => [
      'Annual team dinner and awards ceremony.', 'Meet and greet with fans.', 'Sponsor appreciation day.',
      'Youth academy scouting day.', 'Team-building retreat.'
    ]
  }.freeze
end

if Event.count < 100
  50.times do
    event_type = EVENT_TYPES.sample
    event_datetime = Time.current + rand(1..45).days + rand(8..20).hours
    event_location = EVENT_LOCATIONS.sample
    event_note = EVENT_NOTES[event_type].sample

    Event.create!(
      datetime: event_datetime,
      event_type: event_type,
      location: event_location,
      notes: event_note
    )
  end

  puts "Total users: #{User.count}"
  puts "Total events: #{Event.count}"
end
