require './config/environment'

class UserController < ApplicationController
    register Sinatra::Flash
    
    #signing up
    
    get '/signup' do
        erb :'users/signup'
    end

    post '/users' do
        @user = User.new(name: params[:name],username: params[:username], password: params[:password])
        if @user.save
            session[:user_id] = @user.id
            redirect to '/users/home'
        else
            flash[:message] = "Signup invalid. Please enter in all of the fields."
            redirect to '/signup'
        end
    end

    get '/users/home' do
        @user = current_user
        if !logged_in?
            redirect to '/'
        else
            @songs = @user.songs
            erb :'users/home'
        end
    end

    #logging in

    get '/login' do
        erb :'users/login'
    end

    post '/users/home' do
        @user = User.find_by(username: params[:username])

        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            @songs = @user.songs
            erb :'users/home'
        else
            flash[:message] = "Login invalid. Please try again."
            redirect to '/login'
        end
    end

    #logging out

    get '/logout' do
        session.clear
        redirect to '/'
    end


end