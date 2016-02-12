module PagesHelper

  require 'httparty'
  require 'json'

  def get_welcome
    content_tag(:div, :class=> "welcome col-md-6 col-md-offset-3") do
      content_tag(:h1, get_message, :id => "welcometxt") +
      content_tag(:h1, "", :id => "timetxt") +
      content_tag(:h1, get_todomessage, :id => "todomessage")
    end
  end

  def get_message
    time = Time.new()
    if(time.hour >= 1 && time.hour < 6) then
      return "Can't sleep, Pieter?"
    end

    if(time.hour >= 5 && time.hour < 12) then
      return "Good morning, Pieter."
    end

    if(time.hour >= 12 && time.hour < 17 ) then
      return "Good afternoon, Pieter."
    end

    if(time.hour >= 17 && time.hour < 22) then
      return "Welcome back, Pieter."
    end

    if(time.hour >= 22) then
      return "Getting tired, Pieter?"
    end
  end

  def reddit_search

    url = 'https://www.reddit.com/r/EarthPorn/search.json?q=&restrict_sr=on&sort=top&t=hour&limit=1'

    response = HTTParty.get(url)

    json = JSON.parse(response.body)

    json.fetch('data').fetch('children')[0].fetch('data').fetch('url')
  end

  def get_weather

    url = 'https://api.forecast.io/forecast/059e13194aa7a13e2ac742a1bce77edb/37.4420,-122.1771'

    response = HTTParty.get(url)

    data = JSON.parse(response.body)

    content_tag(:div, :class => "weather col-md-2 col-md-offset-1") do
      content_tag(:i, nil, :class => get_icon(data)) +
      content_tag(:h3, get_sunrise(data)) +
      content_tag(:h3, get_temp(data)) +
      content_tag(:h3, get_main(data)) +
      content_tag(:h3, get_sunset(data))
    end
  end

  def get_icon(data)

    code = data.fetch('currently').fetch('icon')

    return "wi wi-forecast-io-#{code}"
  end

  def get_sunrise(data)

    data = data.fetch('daily').fetch('data')[0].fetch('sunriseTime')

    time = Time.at(data)

    hour = time.hour

    if hour < 10 then
      hour = "0#{hour}"
    end

    min = time.min

    if min < 10 then
      min = "0#{min}"
    end

    "Sunrise #{hour}:#{min}"

  end

  def get_sunset(data)

    data = data.fetch('daily').fetch('data')[0].fetch('sunsetTime')

    time = Time.at(data)

    hour = time.hour

    if hour < 10 then
      hour = "0#{hour}"
    end

    min = time.min

    if min < 10 then
      min = "0#{min}"
    end

    "Sunset #{hour}:#{min}"

  end

  def get_main(data)

    data.fetch('currently').fetch('summary')

  end

  def get_temp(data)

    temp = data.fetch('currently').fetch('temperature')

    temp = temp.round(1)

    "#{temp}°F"
  end

  def get_todo

    content_tag(:div, :class => "todo col-md-4 col-md-offset-1") do
      get_todobody
    end

  end

  def get_calendar
    content_tag(:div, :class => "calendar col-md-2 col-md-offset-1") do
      content_tag(:h3, get_calendarmessage)
    end
  end

  def get_todomessage
    "What do you need to do?"
  end

  def get_todobody
    content_tag(:input, "", :type => "text", :class => "text-line", :placeholder => get_exampleitem) +
    content_tag(:ul, :class => "todolist") do
      content_tag(:li, content_tag(:h3, "Sample", :class => "todotext"), :class => "todoitem")
    end
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

  def get_calendarmessage
    "You have no plans"
  end

end
