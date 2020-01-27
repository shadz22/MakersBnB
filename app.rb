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


  run! if app_file == $0
end

