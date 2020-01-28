require 'user'

describe User do

  describe '.create' do
    it 'creates a new user' do
      user = User.create(name: "David", email: "david@gmail.com", password: "password1")
      expect(user.name).to include("David")
      expect(user.email).to include("david@gmail.com")
    end

    it 'encrypts the password' do
      expect(BCrypt::Password).to receive(:create).with("password1")
      User.create(name: "David", email: "david@gmail.com", password: "password1")
    end
  end

end


