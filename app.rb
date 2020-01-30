require 'sinatra/base'
require './lib/user'
require './lib/listing'
require './database_connection_setup'

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
    # erb :'listings/index'
  end

  get '/listings/:id' do
    @listings = Listing.all
    @listings.each { |listing| session[:listing] = listing if listing.id === params[:id] }
    redirect '/'
  end

  get '/' do
    # erb :index
    @listings = Listing.all
    @current_listing = session[:listing]
    erb :user_index
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

  run! if app_file == $0
end

