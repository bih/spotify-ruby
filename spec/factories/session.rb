FactoryBot.define do
  factory :session, class: Spotify::Accounts::Session do
    association :accounts, factory: :accounts
    access_token { SecureRandom.base64(100) }
    expires_in 3600
    refresh_token { SecureRandom.base64(100) }
    scopes ["user-read-private"]

    skip_create

    initialize_with do
      new(accounts, access_token, expires_in, refresh_token, scopes)
    end
  end
end
