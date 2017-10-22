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
