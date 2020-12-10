require './config/environment'

class UserController < ApplicationController
    
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
            redirect to '/signup'
        end
    end

    get '/users/home' do
        @user = User.find_by(session[:id])
        erb :'users/home'
    end

    #logging in

    get '/login' do
        erb :'users/login'
    end

    post '/users/home' do
        @user = User.find_by(username: params[:username])
        
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            erb :'users/home'
        else
            redirect to '/login'
        end
    end

    #logging out

    get '/logout' do
        session.clear
        redirect to '/'
    end


end