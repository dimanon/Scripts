
class Dlink

  require 'open-uri'
  require 'nokogiri'
  
  def initialize(host, login, passw)
    @host = host
    @login = login
    @passw = passw
    @a = []
    @param = {"mode" => "Mode:",
             "snr" => "SNR Margin (dB):", "att" => "Attenuation (dB):",
             "max_speed" => "Attainable Rate (Kbps):", "speed" => "Rate (Kbps):"}
  end
  
  def get
    @doc = Nokogiri::HTML(open(@host, :http_basic_authentication => [@login, @passw]))
    @doc.xpath('//td').each{|el| @a.push(el.content)}#(парсим) 
  end
  
  def out
    s1 = @param["mode"] + @a[@a.index(@param["mode"]) + 1]
    s2 = @param["snr"] + @a[@a.index(@param["snr"]) + 1] + @a[@a.index(@param["snr"]) + 2]
    s3 = @param["att"] + @a[@a.index(@param["att"]) + 1] + @a[@a.index(@param["att"]) + 2]
    s4 = @param["max_speed"] + @a[@a.index(@param["max_speed"]) + 1] + @a[@a.index(@param["max_speed"]) + 2]
    s5 = @param["speed"] + @a[@a.index(@param["speed"]) + 1] + @a[@a.index(@param["speed"]) + 2]
    return s1 + '|' + s2 + '|' + s3 + '|' + s4 + '|' + s5    
  end
    
end

host = "http://192.168.0.1/statsadsl.html"
login = "admin"
passw = "admin"



modem = Dlink.new(host, login, passw)
 
modem.get
s = modem.out
system("notify-send -u normal -t 5000 -i info '#{s}'")

