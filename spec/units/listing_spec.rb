require_relative '../../lib/listing'
require 'pg'

describe Listing do
  let(:subject) { Listing }
  
  before(:each) do
      DatabaseConnection.setup('bnb_app_test')
      DatabaseConnection.query("INSERT INTO users (id, name, email, password) VALUES (1, 'user1', 'email1', 'password') RETURNING id")
  end

  describe '.all' do
    it { expect(subject.all).to be_a Array }
  end


  describe '.create' do
    it 'creates new listing' do
      listing = subject.create(name: 'My first listing', description: 'Listing description', price: 100, owner_id: 1)
      expect(listing.first['name']).to include('My first listing')
    end
  end
end