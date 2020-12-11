require './config/environment'

class SongController < ApplicationController

    get '/songs' do
        @songs = Song.all.select { |song| song.user_id == current_user.id }
        erb :'songs/index'
    end 

    get '/songs/new' do
        if !logged_in?
            redirect to '/login'
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
        #user can only view the songs they have created -- conditional

        @song = Song.find(params[:id]) #if you type in a song.id that isn't created yet, we should have it reroute to the error page

        if !logged_in?
            redirect to '/login'
        elsif current_user.id == @song.user_id
            erb :'songs/show'              
        else
            erb :'songs/error'
        end
    end
    
    get '/songs/:id/edit' do
        @song = Song.find(params[:id])

        if !logged_in?
            redirect to '/login'
        elsif current_user.id == @song.user_id
            erb :'songs/edit'
        else
            erb :'songs/error'
        end
    end

    patch '/songs/:id' do
        @song = Song.find(params[:id])

        if !logged_in?
            redirect to '/login'
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
