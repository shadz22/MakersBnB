require_relative '../../lib/listing'
require_relative '../../lib/user'
require 'pg'

describe Listing do
  let(:subject) { Listing }
  
 
  let(:user) { User.create(name: 'user1', email: 'email', password: 'password') }

  describe '.all' do
    it { expect(subject.all).to be_a Array }

    it 'wraps database data in Listing object and assigns instance variables' do
      Listing.create(name: 'listing name', description: 'Listing description', price: 100, owner_id: user.id)
      expect(subject.all.first.name).to eq 'listing name'
    end
  end


  describe '.create' do
    it 'creates new listing' do
      listing = subject.create(name: 'My first listing', description: 'Listing description', price: 100, owner_id: user.id)
      expect(listing.first['name']).to include('My first listing')
    end
  end
end