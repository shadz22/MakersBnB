require 'pg'
require './lib/database_connection'

class Listing

  attr_reader :id, :name, :description, :price, :owner_id

  def initialize(database_row)
    @id = database_row['id']
    @name = database_row['name']
    @description = database_row['description']
    @price = database_row['price']
    @owner_id = database_row['owner_id']
  end

  def self.all
    DatabaseConnection.setup(environment)
    query = "SELECT * FROM listings"
    result = DatabaseConnection.query(query)
    result.map { |listing| Listing.new(listing) }
  end

  def self.create(name:, description:, price:, owner_id:)
    DatabaseConnection.setup(environment)
    DatabaseConnection.query("INSERT INTO listings (name, description, price, owner_id) VALUES ('#{name}', '#{description}', '#{price}', '#{owner_id}') RETURNING id, name, description, price, owner_id")
  end

  def self.environment
    ENV['ENVIRONMENT'] == 'test' ? 'bnb_app_test' : 'bnb_app'
  end
end