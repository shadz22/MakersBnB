require 'sinatra/base'
require './lib/user'
require './lib/listing'
require './database_connection_setup'

class BnbApp < Sinatra::Base

  enable :sessions 

  run! if app_file == $0
end

