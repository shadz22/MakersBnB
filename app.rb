require 'sinatra/base'
require './lib/user'
require './lib/listing'
require './lib/booking'
require './database_connection_setup'
require 'json'

class BnbApp < Sinatra::Base

  enable :sessions
  
  get '/listings/new' do
    # erb :'listings/new'
  end

  post '/listings' do
    Listing.create(name: params[:create_name], description: params[:description], price: params[:set_price], owner_id: session[:owner_id], start_date: params[:start_date], end_date: params[:end_date] )
    redirect '/'
  end

  get '/listings' do
    @listings = Listing.all
    @show_listing = {}
    @listings.each { |listing| @show_listing[listing.id] = listing.listing_details}
    @show_listing.to_json
  end

  get '/' do
    # erb :index
    @listings = Listing.all
    erb :booking_index
  end

  get '/users/new' do
    # erb :'users/new'
  end

  post '/users' do
    user = User.create(name: params[:name], email: params[:email], password: params[:password])
    session[:name] = user.name
    session[:owner_id] = user.id
    redirect '/'
  end

  get '/users' do
    @name = session[:name]
  end

  post '/bookings' do
    booking = Booking.create(user_id: params[:user_id], listing_id: params[:listing_id], start_date: params[:start_date], end_date: params[:end_date])
    redirect '/'
  end

  get '/bookings/dates/:id' do
    bookings = Booking.listings(listing_id: params['id'])
  end

  run! if app_file == $0
end

