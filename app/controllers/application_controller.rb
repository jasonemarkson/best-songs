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
  
  #helper methods -- still need to play around with these; will rearrange code to utilize

  helpers do
		def logged_in?
			!!session[:user_id]
    end
    
    # def login(username, password)
    #   user = User.find_by(username: username)

    #   if user && user.authenticate(password)
    #     session[:username] = user.username
    #   else
    #     redirect '/sessions/login'
    #   end
    # end

		def current_user
			User.find(session[:user_id])
    end
    
    # def logout! #why the '!' ?
    #   session.clear
    # end
  end

end
