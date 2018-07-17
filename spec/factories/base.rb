# frozen_string_literal: true

FactoryBot.define do
  factory :base, class: Spotify::SDK::Base do
    association :parent, factory: :sdk
    skip_create
    initialize_with { new(parent) }
  end
end
