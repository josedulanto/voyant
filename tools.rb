require 'thor'
require 'pry'

class Tools < Thor
  desc 'checkpassword PASSWORD', 'check if a password is one of the 1,000 most commonly used passwords'
  def checkpassword(password)
    file = File.read('./1000-most-common-passwords.txt')
    words = file.split(/\n/)
    common_password = words.detect{|word| word.to_s.downcase == password.to_s.downcase}
    puts common_password ? 'Common password' : 'Not common password'
  end
end

Tools.start(ARGV)