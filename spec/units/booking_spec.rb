require 'booking'
require_relative '../../lib/listing'
require_relative '../../lib/user'
require_relative '../../lib/database_connection'
require 'pg'

describe Booking do

  let(:user) { User.create(name: 'user1', email: 'email', password: 'password') }
  let(:listing) { Listing.create(name: 'My first listing', description: 'Listing description', price: 100, owner_id: user.id) }

  describe '.all' do
    it 'creates a new booking array when a new booking is created' do
      listing.map { |i| @listid = i['id']}
      value = ("INSERT INTO bookings VALUES(1, #{user.id}, #{@listid}, '2020-02-22', '2020-02-26');")
      DatabaseConnection.query(value)
      expect(Booking.all).to be_a Array
    end


  end
  
end