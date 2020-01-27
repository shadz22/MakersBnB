require 'sinatra/base'
require './lib/user'
require './lib/listing'
require './database_connection_setup'

class BnbApp < Sinatra::Base

  enable :sessions 

  get '/' do
    erb :index
  end

  get '/users/new' do
    erb :'users/new'
  end

  post '/users' do
    redirect '/users'
  end

  get '/users' do
    erb :'users/index'
  end

  run! if app_file == $0
end

