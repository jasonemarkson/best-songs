require './config/environment'

class SongController < ApplicationController

    get '/songs' do
        @songs = Song.all
        erb :'songs/index'
    end 

    get '/songs/new' do
        if !logged_in?
            redirect to '/'
        else
            erb :'songs/new'
        end
    end

    post '/songs' do
        #check if any fields are blank
        if params[:name] == "" || params[:artist] == "" || params[:genre] == ""
            redirect to "/songs/new"
        else
            song = Song.create(name: params[:name], artist: params[:artist], genre: params[:genre])
            song.user_id = current_user.id
            song.save
            redirect to "/songs/#{song.id}"
        end
    end
    
    get '/songs/:id' do

        if @song = Song.find_by_id(params[:id]) #if you type in a song.id that isn't created yet, we should have it reroute to the error page

            if !logged_in?
                redirect to '/'
            else
                erb :'songs/show'  
            end

        else
            erb :'songs/error'
        end
        
    end
    
    get '/songs/:id/edit' do

        if @song = Song.find_by_id(params[:id]) #added the #find_by_id instead of #find method that was causing the program to break

            if !logged_in?
                redirect to '/'
            else current_user.id == @song.user_id
                erb :'songs/edit'
            end

        else
            erb :'songs/error'
        end

    end

    patch '/songs/:id' do
        @song = Song.find(params[:id])

        if !logged_in?
            redirect to '/'
        elsif params[:name] == "" || params[:artist] == "" || params[:genre] == ""
            redirect to "/songs/#{@song.id}/edit"
        else
            @song = Song.find_by_id(params[:id])
            @new_song = @song.update(name: params[:name], artist: params[:artist], genre: params[:genre])
            redirect to "/songs/#{@song.id}"
        end
    end

    delete '/songs/:id' do
        @song = Song.find_by_id(params[:id])
        @song.delete
        erb :'songs/show'
        redirect to "/songs"
    end

end
