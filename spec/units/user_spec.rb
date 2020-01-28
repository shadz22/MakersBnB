require 'user'

describe User do

  describe '.all' do
    it 'returns all users' do

      connection = PG.connect(dbname: "bnb_app_test")
      connection.exec("INSERT INTO users (name, email) VALUES ('David', 'david@gmail.com');")
      expect(User.all[0].name).to include("David")
      expect(User.all[0].email).to include("david@gmail.com")
    end
  end


  # describe '.create' do
  #   it 'creates a new user' do
  #     User.create("David", "david@gmail.com")
  #     expect(User.all)

end


