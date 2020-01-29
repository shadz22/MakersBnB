require 'pg'
require './lib/database_connection'

class Booking
  def initialize(database_row)
    @id = database_row['id']
    @user_id = database_row['user_id']
    @listing_id = database_row['listing_id']
    @start_date = database_row['start_date']
    @end_date = database_row['end_date']
    @confirmed = database_row['confirmed']
  end

  def self.all
    query = "SELECT * FROM bookings"
    result = DatabaseConnection.query(query)
    result.map { |booking| Booking.new(booking) }
  end

  def self.create(user_id:, listing_id:, start_date:, end_date:)
    DatabaseConnection.query("INSERT INTO bookings (user_id, listing_id, start_date, end_date) VALUES ('#{user_id}', '#{listing_id}', '#{start_date}', '#{end_date}') RETURNING id, user_id, listing_id, start_date, end_date, confirmed")
  end
end