# Spotify API Coverage

This covers all the Spotify API endpoints that are covered.

### Albums Endpoints

| Endpoint                   | Description           | Coverage Status |
| -------------------------- | --------------------- | --------------- |
| GET /v1/albums             | Get Several Albums    | × Not Started   |
| GET /v1/albums/{id}/tracks | Get an Album's Tracks | × Not Started   |

### Artists Endpoints

| Endpoint                             | Description                     | Coverage Status |
| ------------------------------------ | ------------------------------- | --------------- |
| GET /v1/artists                      | Get Several Artists             | × Not Started   |
| GET /v1/artists/{id}/albums          | Get an Artist's Albums          | × Not Started   |
| GET /v1/artists/{id}/top-tracks      | Get an Artist's Top Tracks      | × Not Started   |
| GET /v1/artists/{id}/related-artists | Get an Artist's Related Artists | × Not Started   |

### Tracks Endpoints

| Endpoint       | Description        | Coverage Status |
| -------------- | ------------------ | --------------- |
| GET /v1/tracks | Get Several Tracks | × Not Started   |

### Audio Features Endpoints

| Endpoint                    | Description                           | Coverage Status |
| --------------------------- | ------------------------------------- | --------------- |
| GET /v1/audio-features/{id} | Get Audio Features for a Track        | × Not Started   |
| GET /v1/audio-features      | Get Audio Features for Several Tracks | × Not Started   |

### Analysis Endpoints

| Endpoint                    | Description                    | Coverage Status |
| --------------------------- | ------------------------------ | --------------- |
| GET /v1/audio-analysis/{id} | Get Audio Analysis for a Track | × Not Started   |

### Search Endpoints

| Endpoint       | Description        | Coverage Status |
| -------------- | ------------------ | --------------- |
| GET /v1/search | Search for an Item | × Not Started   |

### Users Endpoints

| Endpoint                | Description                | Coverage Status |
| ----------------------- | -------------------------- | --------------- |
| GET /v1/users/{user_id} | Get a User's Profile       | ×               |
| GET /v1/me              | Get Current User's Profile | [me/info.rb]    |

### Saved Content Endpoints

| Endpoint                   | Description                       | Coverage Status |
| -------------------------- | --------------------------------- | --------------- |
| GET /v1/me/tracks          | Get Current User's Saved Tracks   | × Not Started   |
| GET /v1/me/tracks/contains | Check Current User's Saved Tracks | × Not Started   |
| PUT /v1/me/tracks          | Save Tracks for Current User      | × Not Started   |
| DELETE /v1/me/tracks       | Remove Tracks for Current User    | × Not Started   |
| GET /v1/me/albums          | Get Current User's Saved Albums   | × Not Started   |
| GET /v1/me/albums/contains | Check Current User's Saved Albums | × Not Started   |
| PUT /v1/me/albums          | Save Albums for Current User      | × Not Started   |
| DELETE /v1/me/albums       | Remove Albums for Current User    | × Not Started   |

### Discovery Endpoints

| Endpoint                          | Description                      | Coverage Status |
| --------------------------------- | -------------------------------- | --------------- |
| GET /v1/browse/new-releases       | Get a List of New Releases       | × Not Started   |
| GET /v1/browse/featured-playlists | Get a List of Featured Playlists | × Not Started   |

### Categories Endpoints

| Endpoint                                          | Description                     | Coverage Status |
| ------------------------------------------------- | ------------------------------- | --------------- |
| GET /v1/browse/categories                         | Get a List of Browse Categories | × Not Started   |
| GET /v1/browse/categories/{category_id}           | Get a Single Browse Category    | × Not Started   |
| GET /v1/browse/categories/{category_id}/playlists | Get a Category's playlists      | × Not Started   |

### Recommendation Endpoints

| Endpoint                                      | Description                        | Coverage Status |
| --------------------------------------------- | ---------------------------------- | --------------- |
| GET /v1/recommendations                       | Get Recommendations Based on Seeds | × Not Started   |
| GET /v1/recommendations/available-genre-seeds | Get Available Genre Seeds          | × Not Started   |

### Follow Endpoints

| Endpoint                                                           | Description                                    | Coverage Status                                                        |
| ------------------------------------------------------------------ | ---------------------------------------------- | ---------------------------------------------------------------------- |
| GET /v1/me/following                                               | Get Followed Artists                           | [me.rb]                                                                |
| GET /v1/me/following/contains                                      | Check if Current User Follows Artists or Users | [me.rb]                                                                |
| PUT /v1/me/following                                               | Follow Artists or Users                        | [🔘 Partial Support][artist.rb] (Following multiple isn't supported)   |
| DELETE /v1/me/following                                            | Unfollow Artists or Users                      | [🔘 Partial Support][artist.rb] (Unfollowing multiple isn't supported) |
| GET /v1/users/{user_id}/playlists/{playlist_id}/followers/contains | Check if Users Follow a Playlist               | × Not Started                                                          |
| PUT /v1/users/{user_id}/playlists/{playlist_id}/followers          | Follow a Playlist                              | × Not Started                                                          |
| DELETE /v1/users/{user_id}/playlists/{playlist_id}/followers       | Unfollow a Playlist                            | × Not Started                                                          |

### Playlists Endpoints

| Endpoint                                                  | Description                            | Coverage Status |
| --------------------------------------------------------- | -------------------------------------- | --------------- |
| GET /v1/users/{user_id}/playlists                         | Get a List of a User's Playlists       | × Not Started   |
| GET /v1/me/playlists                                      | Get a List of Current User's Playlists | × Not Started   |
| GET /v1/users/{user_id}/playlists/{playlist_id}           | Get a Playlist                         | × Not Started   |
| GET /v1/users/{user_id}/playlists/{playlist_id}/tracks    | Get a Playlist's Tracks                | × Not Started   |
| POST /v1/users/{user_id}/playlists                        | Create a Playlist                      | × Not Started   |
| POST /v1/users/{user_id}/playlists/{playlist_id}/tracks   | Add Tracks to a Playlist               | × Not Started   |
| DELETE /v1/users/{user_id}/playlists/{playlist_id}/tracks | Remove Tracks from a Playlist          | × Not Started   |
| PUT /v1/users/{user_id}/playlists/{playlist_id}/tracks    | Reorder or replace a Playlist's Tracks | × Not Started   |
| PUT /v1/users/{user_id}/playlists/{playlist_id}           | Change a Playlist's Details            | × Not Started   |

### History Endpoints

| Endpoint                          | Description                                   | Coverage Status |
| --------------------------------- | --------------------------------------------- | --------------- |
| GET /v1/me/top/{type}             | Get User's Top Artists and Tracks             | × Not Started   |
| GET /v1/me/player/recently-played | Get the Current User's Recently Played Tracks | × Not Started   |

### Connect Endpoints

| Endpoint                  | Description                                       | Coverage Status                             |
| ------------------------- | ------------------------------------------------- | ------------------------------------------- |
| GET /v1/me/player         | Get Information About The User's Current Playback | [Full support ✔][connect/playback_state.rb] |
| GET /v1/me/player/devices | Get a User's Available Devices                    | [Full support ✔][connect.rb]                |
| PUT /v1/me/player         | Transfer a User's Playback                        | [Full support ✔][connect/device.rb]         |

### Player Endpoints

| Endpoint                            | Description                                 | Coverage Status                     |
| ----------------------------------- | ------------------------------------------- | ----------------------------------- |
| GET /v1/me/player/currently-playing | Get the User's Currently Playing Track      | × Not implementing                  |
| PUT /v1/me/player/play              | Start/Resume a User's Playback              | [Full support ✔][connect/device.rb] |
| PUT /v1/me/player/pause             | Pause a User's Playback                     | [Full support ✔][connect/device.rb] |
| POST /v1/me/player/next             | Skip User's Playback To Next Track          | [Full support ✔][connect/device.rb] |
| POST /v1/me/player/previous         | Skip User's Playback To Previous Track      | [Full support ✔][connect/device.rb] |
| PUT /v1/me/player/seek              | Seek To Position In Currently Playing Track | [Full support ✔][connect/device.rb] |
| PUT /v1/me/player/repeat            | Set Repeat Mode On User's Playback          | [Full support ✔][connect/device.rb] |
| PUT /v1/me/player/volume            | Set Volume For User's Playback              | [Full support ✔][connect/device.rb] |
| PUT /v1/me/player/shuffle           | Toggle Shuffle For User's Playback          | [Full support ✔][connect/device.rb] |

[connect.rb]: /lib/spotify/sdk/connect.rb
[connect/playback_state.rb]: /lib/spotify/sdk/connect/playback_state.rb
[connect/device.rb]: /lib/spotify/sdk/connect/device.rb
[artist.rb]: /lib/spotify/sdk/artist.rb
[me.rb]: /lib/spotify/sdk/me.rb
[me/info.rb]: /lib/spotify/sdk/me/info.rb
