require 'pg'
require './lib/database_connection'

class Listing
  def self.all
    DatabaseConnection.setup('bnb_app_test')
    query = "SELECT * FROM listings"
    result = DatabaseConnection.query(query)
    result.map { |listing| listing['name']}
  end

  def self.create(name:, description:, price:, owner_id:)
    DatabaseConnection.setup('bnb_app_test')
    DatabaseConnection.query("INSERT INTO listings (name, description, price, owner_id) VALUES ('#{name}', '#{description}', '#{price}', '#{owner_id}') RETURNING id, name, description, price, owner_id")
  end
end