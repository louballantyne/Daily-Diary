require 'sinatra/base'
require 'pg'
require_relative 'lib/diary'

class DiaryManager < Sinatra::Base

  enable :sessions, :method_override

  get '/' do
    redirect '/diary'
  end
# Show summary of entries
  get '/diary' do
    erb(:diary)
  end
# Delete selected entry and redirect to entries page
  delete '/diary/:id' do
    Diary.delete(params[:id])
    redirect '/diary'
  end
# Go to page to enter a new entry
  get '/new_entry' do
    erb(:new_entry)
  end
# Send data to add an entry
  post '/add_entry' do
    Diary.add(params[:date], params[:title], params[:entry])
    redirect '/diary'
  end

  get '/diary/:id' do
    erb(:entry)
  end
# Edit a diary entry
  get '/diary/:id/edit' do
    @id = params[:id]
    erb(:edit_entry)
  end
# Send data to update an entry
  put '/diary/:id' do
    Diary.update(params[:id],params[:date],params[:title],params[:entry])
    redirect '/diary'
  end
# Add a comment to a diary entry
  get '/diary/:id/comment' do
    @id = params[:id]
    erb(:comment)
  end
# send data to add a comment
  post '/diary/:id' do
    Diary.comment(params[:id], params[:comment])
    redirect '/diary'
  end
# Add a tag to a diary entry
  get '/diary/:id/tag' do
    @id = params[:id]
    erb(:tag)
  end
  # send data to add a tag
    post '/diary/:id/add_tag' do
      Diary.tag(params[:id], params[:tag])
      redirect '/diary'
    end
  # search for entries by tag
  post '/search' do
    @tag = params[:search_tag]
    erb(:search)
  end

  run! if app_file == $0
end
