require 'open-uri'
require 'nokogiri'

mode = "Mode:"
snr = "SNR Margin (dB):"
att = "Attenuation (dB):"
host = "http://192.168.0.1/statsadsl.html"
login = "admin"
passw = "admin"

a = []
doc = Nokogiri::HTML(open(host, :http_basic_authentication => [login, passw]))
doc.xpath('//td').each{|el| a.push(el.content)}

puts "Mode            : " + a[a.index(mode)+1]
puts "\t\t  Downstream   Upstream"
puts "SNR Margin (dB) : " + a[a.index(snr)+1] + "\t\t" + a[a.index(snr)+2]
puts "Attenuation (dB): " + a[a.index(att)+1] + "\t\t" + a[a.index(att)+2]
