require './config/environment'

class SongController < Sinatra::Base
    
    configure do
        set :public_folder, 'public'
        set :views, 'app/views'
    end

    get '/songs' do 
        @songs = Song.all
        erb :index
    end 

    get '/songs/new' do
        erb :new
    end

    post '/songs' do
        @song = Song.create(name: params[:name], artist: params[:artist], genre: params[:genre])
        redirect to "/songs/#{@song.id}"
    end

    get '/songs/:id' do
        @song = Song.find_by_id(params[:id])
        erb :show
    end

    get '/songs/:id/edit' do
        @song = Song.find_by_id(params[:id])
        erb :edit
    end

    patch '/songs/:id' do
        @song = Song.find_by_id(params[:id])
        @new_song = @song.update(name: params[:name], artist: params[:artist], genre: params[:genre])
        redirect to "/songs/#{@song.id}"
    end

    delete '/songs/:id' do
        @song = Song.find_by_id(params[:id])
        @song.delete
        erb :show
        redirect to "/songs"
    end

end
