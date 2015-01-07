require "sinatra"

DIRNAME = File.dirname(__FILE__)
set :public_folder, "./iddomjs"

get '/' do
  @results = []
  haml :home
end

get '/:q' do
  result = `rak -il #{params[:q]} "#{DIRNAME}/iddomjs"`.split("\n")
  result.delete_if { |e| ! (/\.html$/ =~ e)  }
  result.delete_if { |e| e == "#{DIRNAME}/index.html" }
  # puts result
  @results = result.map { |e| File.basename(e) }.sort
  haml :index
end

post '/search' do
  # puts params
  redirect "/#{params[:search]}"
end


