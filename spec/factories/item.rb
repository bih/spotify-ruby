# frozen_string_literal: true

FactoryBot.define do
  factory :item, class: Spotify::SDK::Item do
    association :parent, factory: :base

    skip_create
    initialize_with { new(attributes, parent) }
  end
end
