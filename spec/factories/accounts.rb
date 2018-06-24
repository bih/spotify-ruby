# frozen_string_literal: true

FactoryBot.define do
  factory :accounts, class: Spotify::Accounts do
    client_id { Digest::SHA1.hexdigest([Time.now, rand].join) }
    client_secret { Digest::SHA1.hexdigest([Time.now, rand].join) }
    redirect_uri "http://localhost/callback"

    skip_create

    initialize_with do
      new(client_id:     client_id,
          client_secret: client_secret,
          redirect_uri:  redirect_uri)
    end
  end
end
