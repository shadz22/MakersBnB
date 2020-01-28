require 'booking'
require_relative '../../lib/listing'
require_relative '../../lib/user'
require_relative '../../lib/database_connection'
require 'pg'

describe Booking do

  let(:subject) { Booking }
  let(:user) { User.create(name: 'user1', email: 'email', password: 'password') }
  let(:listing) { Listing.create(name: 'My first listing', description: 'Listing description', price: 100, owner_id: user.id) }

  before(:each) do
    listing.map { |i| @listid = i['id']}
  end

  describe '.all' do
    it 'creates a new booking array when a new booking is created' do
      value = ("INSERT INTO bookings VALUES(1, #{user.id}, #{@listid}, '2020-02-22', '2020-02-26');")
      DatabaseConnection.query(value)
      expect(subject.all).to be_a Array
    end
  end

  describe '.create' do
    it 'creates a new booking' do
      booking = subject.create(user_id: user.id, listing_id: @listid, start_date: '2020-02-22', end_date: '2020-02-26')
      expect(booking.first['start_date']).to include('2020-02-22')
    end
  end
  
end