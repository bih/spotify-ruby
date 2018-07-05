# frozen_string_literal: true

FactoryBot.define do
  factory :album, class: Spotify::SDK::Album do
    association :parent, factory: :base

    # Insert columns here.

    skip_create
    initialize_with { new(attributes, parent) }
  end
end
