require 'pg'

p 'setting up the test database...'

def setup_test_database
  DatabaseConnection.setup('bnb_app_test')
  DatabaseConnection.query("TRUNCATE listings, users, bookings;")
end