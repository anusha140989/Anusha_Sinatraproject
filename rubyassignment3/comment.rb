require 'dm-core'
require 'dm-migrations'


class CommentData
  include DataMapper::Resource
  property :id, Serial
  property :name, String
  property :comment, String
  property :created_at, DateTime
end

configure do
  enable :sessions
  set :username, 'frank'
  set :password, 'sinatra'
end

DataMapper.finalize


get '/comments' do
    @comments = CommentData.all
    erb :comments
 end


get '/comments/new' do
  @comment = CommentData.new
  @comment.created_at = Time.now
  erb :new_comment
end

get '/comments/:id' do
  @comment = CommentData.get(params[:id])
  erb :show_comment
end

post '/comments' do
  comment = CommentData.create params[:comment]
  puts params[:comment]
  redirect to("/comments/#{comment.id}")
end

put '/comments/:id' do
  comment = CommentData.get(params[:id])
  comment.update(params[:comment])
  redirect to("/comments/#{comment.id}")
end

