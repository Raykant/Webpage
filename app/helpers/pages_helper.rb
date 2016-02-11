module PagesHelper

  require 'httparty'
  require 'json'

  def reddit_search

    url = 'https://www.reddit.com/r/EarthPorn/search.json?q=&limit=1&restrict_sr=on&sort=top&t=hour'

    response = HTTParty.get(url)

    json = JSON.parse(response.body)

    json.fetch('data').fetch('children')[0].fetch('data').fetch('url')
  end

  def get_time
    time = Time.new()

    time.in_time_zone('Pacific Time (US & Canada)')

    "#{time.hour}:#{time.min}"
  end

  def get_weather

    url = 'http://api.openweathermap.org/data/2.5/weather?id=5408132&appid=8cfd2a75036eac999bda999a76e7f608'

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

    code = data.fetch('weather')[0].fetch('id')

    time = Time.new();

    sunset = Time.at(data.fetch('sys').fetch('sunset'))

    sunrise = Time.at(data.fetch('sys').fetch('sunrise'))

    if(time.hour > sunset.hour) then
      return "wi wi-owm-night-#{code}"
    end
    if(time.hour == sunset.hour && time.min >= sunset.min) then
      return "wi wi-owm-night-#{code}"
    end
    if(time.hour < sunrise.hour) then
      return "wi wi-owm-night-#{code}"
    end
    if(time.hour == sunrise.hour && time.min < sunrise.min) then
      return "wi wi-owm-night-#{code}"
    end

    return "wi wi-owm-day-#{code}"
  end

  def get_sunrise(data)

    data = data.fetch('sys').fetch('sunrise')

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

    data = data.fetch('sys').fetch('sunset')

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

    data.fetch('weather')[0].fetch('description')

  end

  def get_temp(data)

    temp = data.fetch('main').fetch('temp')

    number = (1.8 * (temp - 273.15)) + 32

    number = number.round(1)

    "#{number}°F"
  end

end
