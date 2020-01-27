require 'sinatra/base'
require 'sinatra/flash'
require './lib/user'
require './listing'

class BnbApp < Sinatra::Base

  enable :sessions 

  run! if app_file == $0
end

