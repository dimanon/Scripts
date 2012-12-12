new_name = Time.now.to_s[0..9] + '_pass.txt'
str_file = File.open("user_pass.txt", "r"){ |file| file.read }
File.open(new_name, 'w'){ |file| file.puts str_file.gsub(/\d/){ rand(10).to_s } }
