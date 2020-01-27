require 'sinatra/base'
require './lib/user'
require './lib/listing'
require './database_connection_setup'

class BnbApp < Sinatra::Base

  enable :sessions
  
  get '/listings/new' do
    erb(:new)
  end

  post '/listings' do
    Listing.create(name: params[:create_name], description: params[:description], price params[:set_price])
    redirect '/listings'
  end

  get '/listings' do
    erb(:view)
  end


  run! if app_file == $0
end

