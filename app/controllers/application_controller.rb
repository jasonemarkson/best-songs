require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :home
  end
  
  #helper methods -- still need to play around with these; will rearrange code to utilize these

  helpers do
    def logged_in?
      !!session[:username]
    end

    def login(email, password)
      user = User.find_by_id(params[:id])
      if user && user.authenticate(password)
        session[:username] = user[:username]
      else 
        redirect to 'login'
      end
    end
    
  end

end
