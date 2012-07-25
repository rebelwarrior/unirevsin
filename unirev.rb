##SINATRA::UnicodeReversor##
##Needs to be 1.8.7 compliant because server is 1.8.7 Ruby##

require 'rubygems' if RUBY_VERSION.to_f < 1.9
require 'sinatra'

def unicodereversor(formtext)
  raise unless formtext.class == String #how to raise 503 server err?
  reversed_text = ""
  formtext.each_line do |line|
    reversed_text << line.chomp.scan(/./u).reverse.join("") #scan returns an array
    reversed_text << "\n"
  end
  reversed_text #return quits the sinatra app! HOLY MOSES!
end

get '/' do
  @text = @text || "Sample Unicode Text 
  blah blah blah"
  @title = "Unicode Reversor"
  erb :index  #create text box form w/ submit button view
end

get '/favicon.ico' do
  redirect "http://www.rabbitmoon.org/favicon.ico"
end

post '/' do
  #reverse txt
  @text = unicodereversor(params[:formtext])
  erb :index
end


__END__

@@layout

<!DOCTYPE html> 
<head>
  <meta charset="utf-8" />
  <title> <%= @title %> </title>
</head>
<html> 
  <%= yield %>
</html>

@@index

<body> 
  <p> Put your text below and hit the "Submit" button 
    to reverse the character in each line but keep the lines in order.
  </p> 
<form name="input" action="/" method="post">
  <textarea rows="10" cols="30" type="text" name="formtext"><%= @text %> 
  </textarea> 
  <br /><br />
  <input type="submit" value="Submit" />
</form> 
</body> 

