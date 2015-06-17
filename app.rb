require 'sinatra'
require 'sinatra/activerecord'
#require 'sinatra/contrib'
require 'securerandom'
require 'json'
require './models'

set :protection, :except => [:session_hijacking]
set :public_folder, 'public'

"""
db = URI.parse('postgres://app_user:password@127.0.0.1:5432/wof')

ActiveRecord::Base.establish_connection(
  :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
  :host     => db.host,
  :username => db.user,
  :password => db.password,
  :database => db.path[1..-1],
  :encoding => 'utf8'
)
"""


ENV['RACK_ENV'] ||= 'development'

set :database_file, "config/database.yml"

get '/users/:id/' do
    content_type :json
	  if "#{params['id']}" == '1'
	  	puts session['username']
	  	{ :username => 'pavlov',
	  		 :email => 'pavlov@example.com',
	  		 :description => 'Congrats! This is the admin account.' }.to_json
	  elsif "#{params['id']}" == '2'
	  	{ :username => 'demo',
	  		 :email => 'demo@example.com',
	  		 :description => 'This is a demo account' }.to_json
	  else
	  	status 404
	  end
	end

get '/logout' do
  session.clear
  erb :login
end
 
get '/login' do
	erb :login
end

get '/' do
    redirect "/login"
end

post '/login' do
	email = params[:inputEmail]
	session[:session_id] = "bob"
	password = params[:inputPassword]
	if email == 'pavlov@example.com' && password == 'bells'
	  	session[:username] = "user1"
		response.set_cookie 'session_id', (Digest::SHA1.hexdigest email)
		response.set_cookie 'user_id', 1
		redirect "/profile"
	elsif email == "demo@example.com" && password == 'demo'
		response.set_cookie 'session_id', (Digest::SHA1.hexdigest email)
		response.set_cookie 'user_id', 2
		redirect "/profile"
	else
		erb :login
	end
end

get '/profile' do
	session_id = request.cookies["session_id"]
	if session_id == (Digest::SHA1.hexdigest 'pavlov@example.com')
		is_admin = true
	end
	@names = Names.order("created_at DESC")
	#redirect "/profile" if @names.empty?
	erb :profile, :locals => {:is_admin => is_admin, :names => @names}
end

post '/profile' do
	session_id = request.cookies["session_id"]
	if session_id == (Digest::SHA1.hexdigest 'pavlov@example.com')
		@name = Names.new(params[:name])
		if @name.save
			redirect "/profile"
		else
			erb :new
		end
	end
	status 403
end


