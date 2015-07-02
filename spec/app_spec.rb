
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
  let(:json) { JSON.parse(last_response.body) }

  before { get route }

  describe 'when user is admin' do
    let(:route) { '/users/1/'}

    it { expect(last_response).to be_ok }
    it { expect(json['username']).to eq 'pavlov' }
  end

  describe 'when user is normal' do
    let(:route) { '/users/2/'}

    it { expect(last_response).to be_ok }
    it { expect(json['username']).to eq 'demo' }
  end
end



