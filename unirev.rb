#! /usr/bin/env ruby

## SINATRA::UnicodeReversor ##
## Code should be 1.8.7 complient because I wrote it a long time. ##

require 'rubygems' if RUBY_VERSION.to_f < 1.9
require 'sinatra'

def unicode_reversor(form_text)
  raise unless form_text.class == String #how to raise 503 server err?
  reversed_text = ""
  form_text.each_line do |line|
    # the following code is 1.8.7 compatible which is cool.
    reversed_text << line.chomp.scan(/./u).reverse.join("") #scan returns an array
    reversed_text << "\n"
  end
  reversed_text #return quits the sinatra app! HOLY MOSES!
end

get '/' do
  @text = @text || "Sample Unicode Text: 
  Ünicørns are 20% cooler."
  @title = "Unicode Reversor"
  erb :index  #create text box form w/ submit button view
end

post '/' do
  @text = unicode_reversor(params[:formtext])
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
  <h1> Unicode Text Reversor </h1>
  <p> Place text in the box below and hit the button  
    to reverse the character in each line but keep the lines in order.
  </p> 
<form name="input" action="/" method="post">
  <textarea rows="10" cols="30" type="text" name="formtext"><%= @text %> 
  </textarea> 
  <br /><br />
  <input type="submit" value="Reverse Text" />
</form> 
</body> 

