# frozen_string_literal: true

FactoryBot.define do
  factory :image, class: Spotify::SDK::Image do
    association :parent, factory: :accounts
    url { "https://i.scdn.co/image/%s" % Digest::SHA1.hexdigest([Time.now, rand].join) }
    width 640
    height 640

    skip_create

    initialize_with do
      new(attributes, parent)
    end
  end
end
