require 'sinatra'
require 'sinatra/reloader'
require './lib/movie'
require './lib/theatre'
require 'pry'
require 'pg'

DB = PG.connect({:dbname => 'theatrix'})
also_reload 'lib/**/*.rb'

get '/' do
    @page = 'Home'
    @css = 'home'
    erb :index
end

get '/theatres' do
    @oage = 'Theatres'
    @css = 'theatres'
    @theatres = Theatre.all
    erb :theatres
end

get '/theatres/new' do
    @oage = 'New Theatre'
    @css = 'new'
    erb :theatres_new
end
post '/theatres' do
    Theatre.new(params).save
    redirect to '/theatres'
end

get '/theatres/:id' do
    @theatre = Theatre.find(params[:id].to_i)
    @oage = @theatre.name
    @css = 'theatre_view'
    erb :theatres_ID
end

get '/theatres/:id/edit' do
    @theatre = Theatre.find(params[:id].to_i)
    @oage = "Editing #{@theatre.name}"
    @css = 'edit'
    erb :theatres_ID_edit
end
patch '/theatres/:id' do
  Theatre.find(params[:id].to_i).update(params)
  redirect to "/theatres/#{params[:id]}"
end
delete '/theatres/:id' do
  Album.find(params[:id].to_i).delete
  redirect to '/theatres'
end
