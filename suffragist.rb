require 'sinatra'
require 'yaml/store'

CHOICES = {
  'HAM' => 'Hamburger',
  'PIZ' => 'Pizza',
  'CUR' => 'Curry',
  'NOO' => 'Noodles',
}

configure do
  set :port, 3000
end

# Route for / - home directory
get '/' do
  @title = 'Welcome to the Suffragist!' # Set @title var for view
  erb :index # run ERB on index.erb
end

# Route for /cast post
post '/cast' do
  @title = 'Thanks for casting your vote!'
  @vote  = params['vote']

  # YAML based storage
  @store = YAML::Store.new 'votes.yml'
  @store.transaction do
    @store['votes'] ||= {}
    @store['votes'][@vote] ||= 0
    @store['votes'][@vote] += 1
  end
  
  erb :cast
end

# Route for /results page
get '/results' do
  @votes = { 'HAM' => 7, 'PIZ' => 5, 'CUR' => 3 }
  @store = YAML::Store.new 'votes.yml'
  @votes = @store.transaction { @store['votes'] }
  erb :results
end


