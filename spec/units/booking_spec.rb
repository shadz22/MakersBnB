# frozen_string_literal: true

require 'booking'
require_relative '../../lib/listing'
require_relative '../../lib/user'
require_relative '../../lib/database_connection'
require 'pg'

describe Booking do
  let(:subject) { Booking }
  let(:user) { User.create(name: 'user1', email: 'email', password: 'password') }
  let(:listing) { Listing.create(name: 'My first listing', description: 'Listing description', price: 100, owner_id: user.id, start_date: '2020-01-01', end_date: '2020-01-02') }
  let(:listing) { Listing.create(name: 'My second listing', description: 'Listing description', price: 90, owner_id: user.id, start_date: '2020-01-01', end_date: '2020-01-02') }

  before(:each) do
    listing.map { |i| @listid = i['id'] }
  end

  describe '.all' do
    it 'creates a new booking array when a new booking is created' do
      Booking.create(user_id: user.id, listing_id: @listid, start_date: '2020-02-22', end_date: '2020-02-26')
      expect(subject.all).to be_a Array
    end
  end

  describe '.create' do
    it 'creates a new booking' do
      booking = subject.create(user_id: user.id, listing_id: @listid, start_date: '2020-02-22', end_date: '2020-02-26')
      expect(booking.first['start_date']).to include('2020-02-22')
    end
  end

  describe '.listings' do
    it 'creates a new booking array for only the listings associated with a specific listing' do
      listing.map do |i|
        @listid = i['id']
        Booking.create(user_id: user.id, listing_id: @listid, start_date: '2020-02-22', end_date: '2020-02-26')
      end
    expect(subject.listings(listing_id: @listid)).to be_a Array
    end
  end
end
