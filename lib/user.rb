require 'pg'
require 'bcrypt'
require './lib/database_connection'

class User

  attr_reader :name, :email, :id, :password

  def initialize(database_row)
    @name = database_row['name']
    @email = database_row['email']
    @id = database_row['id']
    @password = database_row['password']
  end

  def self.all
    query = ("SELECT * FROM users ")
    result = DatabaseConnection.query(query)
    result.map { |user| user }
  end

  def self.create(name:, email:, password:)
    encrypted_password = BCrypt::Password.create(password)
    query = ("INSERT INTO users (name, email, password) VALUES('#{name}', '#{email}', '#{encrypted_password}') RETURNING id, name, email, password")
    result = DatabaseConnection.query(query)
    User.new(result[0])
  end

  def self.authenticate(email:, password:)
    query = ("SELECT * FROM users WHERE email = '#{email}'")
    result = DatabaseConnection.query(query)
    return unless result.any?
    User.new(result[0])
  end

end