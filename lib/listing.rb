require 'pg'
require './lib/database_connection'

class Listing

  attr_accessor :id, :name, :description, :price, :owner_id, :start_date, :end_date, :listing_details

  def initialize(database_row)
    @id = database_row['id']
    @name = database_row['name']
    @description = database_row['description']
    @price = database_row['price']
    @owner_id = database_row['owner_id']
    @start_date = database_row["start_date"]
    @end_date = database_row["end_date"]
    @listing_details = {
      :id => database_row['id'], 
      :name => database_row['name'], 
      :description => database_row['description'],
      :price => database_row['price'],
      :owner_id => database_row['owner_id'],
      :start_date => database_row["start_date"],
      :end_date => database_row["end_date"],
    }
  end

  def self.all
    query = "SELECT * FROM listings"
    result = DatabaseConnection.query(query)
    result.map { |listing| Listing.new(listing) }
  end

  def self.create(name:, description:, price:, owner_id:, start_date:, end_date:)
    DatabaseConnection.query("INSERT INTO listings (name, description, price, owner_id, start_date, end_date) VALUES ('#{name}', '#{description}', '#{price}', '#{owner_id}', '#{start_date}', '#{end_date}') RETURNING id, name, description, price, owner_id, start_date, end_date")
  end

end
