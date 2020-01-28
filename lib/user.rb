require 'pg'
require 'bcrypt'

class User

  attr_reader :name, :email, :id

  def initialize(name, email, id)
    @name = name
    @email = email
    @id = id
  end

  def self.all
    DatabaseConnection.setup('bnb_app_test')
    query = ("SELECT * FROM users ")
    result = DatabaseConnection.query(query)
    result.map { |user| self.new( user["name"], user["email"], user["id"]) }
  end

  def self.create(name, email, password)
    DatabaseConnection.setup('bnb_app_test')
    encrypted_password = BCrypt::Password.create(password)
    query = ("INSERT INTO users (name, email, password) VALUES('#{name}', '#{email}', '#{encrypted_password}')")
    result = DatabaseConnection.query(query)
  end

end