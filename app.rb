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
    Diary.add(params[:date],params[:entry])
    redirect '/diary'
  end

  run! if app_file == $0

end
