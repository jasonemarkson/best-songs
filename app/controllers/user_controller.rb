require './config/environment'

class UserController < Sinatra::Base
    
    configure do
        set :public_folder, 'public'
        set :views, 'app/views'
      end

    #signing up
    
    get '/registrations/signup' do
        erb :'registrations/signup'
    end

    post '/registrations' do
        @user = User.new(name: params[:name],username: params[:username], password: params[:password])
        
        if @user.save
            session[:user_id] = @user.id
            redirect to '/users/home'
        else
            redirect to '/signup'
        end
    end

    get '/users/home' do
        @user = User.find_by(session[:id])
        erb :'users/home'
    end

    #logging in

    get '/sessions/login' do
        erb :'/sessions/login'
    end

    post '/sessions' do
        @user = User.find_by(username: params[:username])
        
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            erb :'users/home'
        else
            redirect to '/sessions/login'
        end
    end

    #logging out

    get '/sessions/logout' do
        session.clear
        redirect to '/'
    end

    

end