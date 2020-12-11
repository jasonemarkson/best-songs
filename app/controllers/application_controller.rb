require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "orange"
  end

  get '/' do
    erb :home
  end
  
  #helper methods
  
  helpers do
		def logged_in?
			!!session[:user_id]
    end


		def current_user
			User.find_by_id(session[:user_id])
    end

  end

end
