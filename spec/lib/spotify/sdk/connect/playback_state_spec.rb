# frozen_string_literal: true

require "spec_helper"

RSpec.describe Spotify::SDK::Connect::PlaybackState do
  shared_context "contains core playback state methods" do
    describe "#to_h" do
      it "returns the correct value" do
        expect(subject.to_h).to eq raw_data
      end
    end

    describe "#device" do
      it "returns an instance of Spotify::SDK::Connect::Device" do
        expect(subject.device).to be_kind_of Spotify::SDK::Connect::Device
      end

      it "returns the correct value" do
        expect(subject.device.to_h).to eq raw_data[:device]
      end
    end

    describe "#playing?" do
      it "is an alias for #is_playing" do
        expect(subject.playing?).not_to be_nil
        expect(subject.playing?).to eq subject.is_playing
      end
    end

    describe "#shuffling?" do
      it "is an alias for #shuffle_state" do
        expect(subject.shuffling?).not_to be_nil
        expect(subject.shuffling?).to eq subject.shuffle_state
      end
    end

    describe "#repeat_mode" do
      it "is a symbolized alias for #shuffle_state" do
        expect(subject.repeat_mode).not_to be_nil
        expect(subject.repeat_mode).to eq subject.repeat_state.to_sym
      end
    end

    describe "#time" do
      it "returns a Time object based on #timestamp" do
        expect(subject.time).to eq Time.at(subject.timestamp / 1000)
      end
    end
  end

  context "in a private listening session" do
    let(:raw_data) { read_fixture("get/v1/me/player/currently-playing/private-session") }
    let(:session) { build(:session, access_token: "access_token") }
    let(:connect_sdk) { Spotify::SDK::Connect.new(Spotify::SDK.new(session)) }
    subject { Spotify::SDK::Connect::PlaybackState.new(raw_data, connect_sdk) }

    include_context "contains core playback state methods"

    describe "#position" do
      it "returns nil" do
        expect(subject.position).to be_nil
      end
    end

    describe "#position_percentage" do
      it "returns nil" do
        expect(subject.position_percentage).to be_nil
      end
    end

    describe "#artists" do
      it "raises an error related to private session" do
        expect { subject.artists }.to raise_error(RuntimeError, /private session/i)
      end
    end

    describe "#artist" do
      it "raises an error related to private session" do
        expect { subject.artist }.to raise_error(RuntimeError, /private session/i)
      end
    end

    describe "#item" do
      it "raises an error related to private session" do
        expect { subject.item }.to raise_error(RuntimeError, /private session/i)
      end
    end
  end

  context "in a public listening session" do
    let(:raw_data) { read_fixture("get/v1/me/player/currently-playing/public-session") }
    let(:session) { build(:session, access_token: "access_token") }
    let(:connect_sdk) { Spotify::SDK::Connect.new(Spotify::SDK.new(session)) }
    subject { Spotify::SDK::Connect::PlaybackState.new(raw_data, connect_sdk) }

    include_context "contains core playback state methods"

    describe "#position" do
      it "is an alias for #progress_ms" do
        expect(subject.position).not_to be_nil
        expect(subject.position).to eq subject.progress_ms
      end
    end

    describe "#position_percentage" do
      it "calculates the percentage to 2 decimal places based on #position and #item.duration_ms" do
        expect(subject.position_percentage).to eq 53.63
      end

      it "calculates the percentage to N decimal places based on #position and #item.duration_ms" do
        expect(subject.position_percentage(3)).to eq 53.621
      end
    end

    describe "#artists" do
      it "returns an Array of Spotify::SDK::Artist instances" do
        expect(subject.artists).to be_kind_of(Array)
        expect(subject.artists[0]).to be_kind_of(Spotify::SDK::Artist)
      end
    end

    describe "#artist" do
      it "returns the first item from #artists" do
        expect(subject.artist).to eq subject.artists[0]
      end
    end

    describe "#item" do
      it "returns a Spotify::SDK::Item object" do
        expect(subject.item).to be_kind_of(Spotify::SDK::Item)
      end

      it "sends the correct information" do
        item_data  = raw_data.dup
        track      = item_data.delete(:track) || item_data.delete(:item)
        properties = item_data.except(:parent, :device, :repeat_state, :shuffle_state)

        expect(subject.item.to_h).to eq track.merge(properties: properties)
      end
    end
  end
end
