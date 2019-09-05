# frozen_string_literal: true

require 'dotenv/load'
require 'thor'
require 'pry'

class Tools < Thor
  desc 'checkpassword PASSWORD',
       'check if a password is one of the 1,000 most commonly used passwords'
  def checkpassword(password)
    file = File.read('./1000-most-common-passwords.txt')
    words = file.split(/\n/)
    common_password = words.detect do |word|
      word.to_s.downcase == password.to_s.downcase
    end
    puts common_password ? 'Common password' : 'Not common password'
  end

  desc 'weather ZIPCODE --country COUNTRY', 'finds the live weather for a zip code'
  option :country, default: 'us', desc: 'country'
  def weather(zipcode)
    response = owm_api_for_zipcode(zipcode, country: options[:country])
    body = JSON.parse(response.body)

    msg = if response.code == '200'
            "#{body['weather'][0]['main']} #{body['main']['temp_max']}" \
            ' degrees Kelvin'
          else
            "Status #{body['cod']}: #{body['message']}"
          end

    puts msg
  end

  private

  def owm_api_for_zipcode(zipcode, country: 'us')
    country = country.to_s.downcase
    uri = URI('http://api.openweathermap.org/data/2.5/weather' \
      "?zip=#{zipcode},#{country}&appid=#{ENV['OPENWEATHERMAP_API_KEY']}")
    Net::HTTP.get_response(uri)
  end
end

Tools.start(ARGV)
