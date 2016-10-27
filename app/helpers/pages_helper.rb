module PagesHelper

  require 'httparty'
  require 'json'

  def get_welcome
    content_tag(:div, :class => "welcome col-xs-8 col-xs-offset-2") do
      content_tag(:h1, "", :id => "welcometxt") +
      content_tag(:h1, "", :id => "timetxt")
    end
  end

  def reddit_search

    Rails.cache.fetch("reddit", expires_in: 45.minutes) do
      reddit_cache
    end
  end

  def reddit_cache
    url = 'https://www.reddit.com/r/EarthPorn/.json?q=&restrict_sr=on&sort=hot&t=day&limit=5'
    response = HTTParty.get(url)
    json = JSON.parse(response.body)

    i = 0;
    while(i < 5) do
      url = json.fetch('data').fetch('children')[i].fetch('data').fetch('url')

      if url.include? "imgur" then
        if !(/\.(jpg|jpeg|png|gif)/ =~ url) then
          url += '.png'
        end

        size = FastImage.size(url);
        if size[0] > 999 && size[1] > 999 then
          return url;
        end
      end

      i += 1
    end
  end

<<<<<<< HEAD
  def get_weather
    @ip = request.remote_ip
    puts(@ip)
    url = "https://freegeoip.net/json/#{@ip}"
    response = HTTParty.get(url)
    json = JSON.parse(response.body)
    lon = json.fetch('longitude')
    lat = json.fetch('latitude')

    puts(lat)
    puts(lon)

    url = "https://api.darksky.net/forecast/059e13194aa7a13e2ac742a1bce77edb/#{lat},#{lon}"

    response = HTTParty.get(url)
    json = JSON.parse(response.body)

    code = json.fetch('currently').fetch('icon');
    icon = "wi wi-forecast-io-#{code}"

    temperature = json.fetch('currently').fetch('temperature')
    puts(icon)
    puts(temperature)

    return content_tag(:i, :class => code) + content_tag(:h3, temperature)
=======
  def get_icon(data)

    code = data.fetch('currently').fetch('icon')

    return "wi wi-forecast-io-#{code}"
  end

  def get_temp(data)

    temp = data.fetch('currently').fetch('temperature')

    temp = temp.round(1)

    "#{temp}°F"
>>>>>>> 06fe587bddb9f423e4602a93f14071422d6793bf
  end

  def get_todo
    content_tag(:ul, :class => "todolist") do
      Todo.all.each do |todo|
        concat(
            content_tag(:li, id: "#{todo.id}") do
              content_tag(:h3, :class => "todoitem") do
                link_to(todo.item, "todos/#{todo.id}", :class => "itemlink", :method => :delete, remote: true)
              end
            end
        )
      end
    end
  end

  def get_todomessage
    if Todo.count > 0 then
      return "Here's what I have for you:"
    end
    "What do you need to do?"
  end

  def get_exampleitem
    num = rand(5)
    return case num
             when 0
               "Read chapter 1 of ..."
             when 1
               "Finish Ch. 7 Prob ..."
             when 2
               "Write paragraph on ..."
             when 3
               "Finish programming ..."
             when 4
               "Model part for ..."
           end
  end
end
