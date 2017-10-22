Core files: # This is all the core files.
- /lib/spotify/version.rb
- /spec/spotify_spec.rb

Authorization: # For integrating OAuth.
- /lib/spotify/auth/*.rb
- /spec/lib/spotify/auth/*_spec.rb

  Code sample:
  ```
    require "spotify"

    auth = Spotify::Auth.new({
      client_id: "client id",
      client_secret: "client_secret",
      redirect_uri: ""
    })
  ```

SDK: # For building amazing things.

  Initialization accepts:
    - OAuth2::AccessToken instance
    - Plain Access Token
    - Query Hash containing access_token
    - Query String containing access_token
    - URL String containing a query or fragment containing access_token

  Code sample:
  ```
  sdk = Spotify::SDK.new(access_token)
  sdk.connect.devices
  ```