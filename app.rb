require 'sinatra/base'
require 'pg'
require_relative 'lib/diary'

class DiaryManager < Sinatra::Base

  enable :sessions, :method_override

  get '/' do
    redirect '/diary'
  end

  get '/diary' do
    erb(:diary)
  end

  delete '/diary/:id' do
    Diary.delete(params[:id])
    redirect '/diary'
  end

  get '/new_entry' do
    erb(:new_entry)
  end

  post '/add_entry' do
    Diary.add(params[:date], params[:title], params[:entry])
    redirect '/diary'
  end

  get '/diary/:id' do
    erb(:entry)
  end

  get '/diary/:id/edit' do
    @id = params[:id]
    erb(:edit_entry)
  end

  put '/diary/:id' do
    Diary.update(params[:id],params[:date],params[:title],params[:entry])
    redirect '/diary'
  end

  run! if app_file == $0

end
