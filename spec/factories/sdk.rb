# frozen_string_literal: true

FactoryBot.define do
  factory :sdk, class: Spotify::SDK do
    association :session, factory: :session
    skip_create
    initialize_with { new(session) }
  end
end
