require 'dm-core'
require 'dm-migrations'

class StudentData
  include DataMapper::Resource
  property :id, Serial
  property :sfname, String
  property :slname, String
  property :major, String
  property :gpa, Float
  property :birthday, Date
  property :address, String
  property :sid, String
end

configure do
  enable :sessions
  set :username, 'frank'
  set :password, 'sinatra'
end

DataMapper.finalize

get '/songs' do
  if session[:admin]
    @songs = StudentData.all
    erb :songs
  else
    erb :ask_login
  end
end

get '/songs/new' do
  halt(401,'Not Authorized') unless session[:admin]
  @song = StudentData.new
  erb :new_song
end

get '/songs/:id' do
  @song = StudentData.get(params[:id])
  erb :show_song
end

get '/songs/:id/edit' do
  @song = StudentData.get(params[:id])
  erb :edit_song
end

post '/songs' do  
  song = StudentData.create params[:song]
  puts params[:song]
  redirect to("/songs/#{song.id}")
end

put '/songs/:id' do
  song = StudentData.get(params[:id])
  song.update(params[:song])
  redirect to("/songs/#{song.id}")
end

delete '/songs/:id' do
  StudentData.get(params[:id]).destroy
  redirect to('/songs')
end
