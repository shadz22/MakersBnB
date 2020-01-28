require_relative '../../lib/listing'
require_relative '../../lib/user'
require 'pg'

describe Listing do
  let(:subject) { Listing }

  let(:user) { User.create(name: 'user1', email: 'email', password: 'password') }

  describe '.all' do
    it { expect(subject.all).to be_a Array }

    it 'wraps database data in Listing object and assigns instance variables' do
      Listing.create(name: 'listing name', description: 'Listing description', price: 100, owner_id: user.id, start_date: '2020-01-01', end_date: '2020-01-02')
      expect(subject.all.first.name).to eq 'listing name'
    end

    it "has a start_date and an end_date" do
      Listing.create(name: 'listing name', description: 'Listing description', price: 100, owner_id: user.id, start_date: '2020-01-01', end_date: '2020-01-02')
      expect(subject.all.first.start_date).to eq('2020-01-01')
      expect(subject.all.first.end_date).to eq('2020-01-02')
    end

  end

  describe '.create' do
    it 'creates new listing' do
      listing = subject.create(name: 'My first listing', description: 'Listing description', price: 100, owner_id: user.id, start_date: '2020-01-01', end_date: '2020-01-02')
      expect(listing.first['name']).to include('My first listing')
    end
  end
end