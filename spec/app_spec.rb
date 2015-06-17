
ENV['RACK_ENV'] = 'test'

require File.expand_path '../../app.rb', __FILE__
require 'spec_helper'
require 'rspec'
require 'rack/test'

describe 'The WOF web app' do
  it 'has an index page that redirects' do
    get '/'
    expect(last_response.status).to eq(302)

    follow_redirect!
    expect(last_request.path).to eq('/login')
  end

  it 'has a login page' do
    get '/login'
    expect(last_response).to be_ok
  end
end

describe 'Users API' do
  it 'can get an admin user' do
    get '/users/1/'
    expect(last_response).to be_ok
    json = JSON.parse(last_response.body)
    expect(json['username']).to eq('pavlov')
  end

  it 'can get a normal user' do
    get '/users/2/'
    expect(last_response).to be_ok
    json = JSON.parse(last_response.body)
    expect(json['username']).to eq('demo')
  end
end



