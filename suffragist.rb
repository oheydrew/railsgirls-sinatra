require 'sinatra'

CHOICES = {
  'HAM' => 'Hamburger',
  'PIZ' => 'Pizza',
  'CUR' => 'Curry',
  'NOO' => 'Noodles',
}

# Route for / - home directory
get '/' do
  @title = 'Welcome to the Suffragist!' # Set @title var for view
  erb :index # run ERB on index.erb
end

post '/cast' do
  @title = 'Thanks for casting your vote!'
  @vote  = params['vote']
  erb :cast
end