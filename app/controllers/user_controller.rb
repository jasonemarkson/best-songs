require './config/environment'

class UserController < Sinatra::Base
    configure do
        set :public_folder, 'public'
        set :views, 'app/views'
      end
end