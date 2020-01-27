require 'pg'

p 'setting up the test database...'

def setup_test_database
  connection = PG.connect(dbname: 'bnb_app_test')
  connection.exec("TRUNCATE listings, users;")
end