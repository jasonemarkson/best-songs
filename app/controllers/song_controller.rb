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
        @song = Song.create(name: params[:name], artist: params[:artist], genre: params[:genre])
        @song.user_id = current_user.id
        @song.save
        redirect to "/songs/#{@song.id}"
    end
    
    get '/songs/:id' do
        @song = Song.find(params[:id])
        erb :'songs/show'
    end
    
    get '/songs/:id/edit' do
        @song = Song.find(params[:id])
        binding.pry
        
        
        if !logged_in?
            redirect to '/login'
        # elsif current_user.id == params[:id]
        #     erb :'songs/error'
        else
            @song = Song.find(params[:id])
            erb :'songs/edit'
        end
    end

    patch '/songs/:id' do
        @song = Song.find_by_id(params[:id])
        @new_song = @song.update(name: params[:name], artist: params[:artist], genre: params[:genre])
        redirect to "/songs/#{@song.id}"
    end

    delete '/songs/:id' do
        @song = Song.find_by_id(params[:id])
        @song.delete
        erb :'songs/show'
        redirect to "/songs"
    end

end
