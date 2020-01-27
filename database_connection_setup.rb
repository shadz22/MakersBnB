require './lib/database_connection'

if ENV['ENVIRONMENT'] == 'test'
  DatabaseConnection.setup('bnb_app_test')
else
  DatabaseConnection.setup('bnb_app')
end
