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

  describe '.authenticate' do
    it 'returns a user given a correct username and password, if one exists' do
      user = User.create(name: 'test', email: 'test@example.com', password: 'password123')
      authenticated_user = User.authenticate(email: 'test@example.com', password: 'password123')
  
      expect(authenticated_user.id).to eq user.id
    end

    it 'returns nil given an incorrect email address' do
      user = User.create(name: 'Shadi', email: 'test@example.com', password: 'password123')
  
      expect(User.authenticate(email: 'nottherightemail@me.com', password: 'password123')).to be_nil
    end
  end
    
end




