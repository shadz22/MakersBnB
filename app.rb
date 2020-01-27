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
    # Listing.create(name: params[:create_name], description: params[:description], price: params[:set_price])
    session[:name] = params[:create_name]
    session[:description] = params[:description]
    session[:price] = params[:set_price]
    redirect '/listings'
  end

  get '/listings' do
    @name = session[:name]
    @description = session[:description]
    @price = session[:price]
    erb :'listings/display'
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

