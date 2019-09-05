# frozen_string_literal: true

require 'dotenv/load'
require 'thor'
require 'pry'
require 'csv'

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

  desc 'weather ZIPCODE --country COUNTRY',
       'finds the live weather for a zip code'
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

  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
  desc 'phoneparser PHONE', 'Phone number parser'
  def phoneparser(phone)
    country = 'United States'
    numbers = phone.gsub(/\D+/, '')
    phone_number = ''
    code = ''

    if numbers.length > 10
      first_three, remaining_numbers = numbers
                                       .match(/^(.{0,3})(.{0,15})\s*$/)
                                       .captures
      csv = CSV.read('./countryCodes.csv')
      3.times do |n|
        try_code = first_three.slice(0, n + 1)
        country, code = csv.detect { |row| row[1] == try_code }
        next unless code

        first_three.slice!(0, n + 1)
        phone_number = first_three + remaining_numbers
        break
      end
    else
      code = '1'
      phone_number = numbers
    end

    puts "#{country} +#{code}#{phone_number}"
  end
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

  private

  def owm_api_for_zipcode(zipcode, country: 'us')
    country = country.to_s.downcase
    uri = URI('http://api.openweathermap.org/data/2.5/weather' \
      "?zip=#{zipcode},#{country}&appid=#{ENV['OPENWEATHERMAP_API_KEY']}")
    Net::HTTP.get_response(uri)
  end
end

Tools.start(ARGV)
