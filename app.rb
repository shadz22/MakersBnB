require 'sinatra/base'
require './lib/user'
require './lib/listing'
require './database_connection_setup'

class BnbApp < Sinatra::Base

  enable :sessions
  
  get '/listings/new' do
    erb :'listings/new'
  end

  post '/listings' do
    Listing.create(name: params[:create_name], description: params[:description], price: params[:set_price], owner_id: 1)
    redirect '/listings'
  end

  get '/listings' do
    @listings = Listing.all
    erb :'listings/index'
  end


  get '/' do
    erb :index
  end

  get '/users/new' do
    erb :'users/new'
  end

  post '/users' do
    session[:name] = params[:name]
    redirect '/users'
  end

  get '/users' do
    @name = session[:name]
    erb :'users/index'
  end

  run! if app_file == $0
end

