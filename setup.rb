## author : Liazid METDAOUI ##
## Dependencies 
# => Git
# => RUBY (OBVIOUSLY)
# => wget
# => Compass
# => Uglifier
# => jpegoptim 
# => optipng

#!/usr/bin/env ruby
# encoding: utf-8

require 'open-uri'
require 'net/http'
## HTTPS ##
require 'net/https'
require 'socket'

def command(cmd)
	if(system(cmd))	
		then puts "Succès"
		else puts "Echec"
	end
end

def download(link, folder, filename)
	link = URI.parse(link)
	if(link.scheme == "http")
		then
  			Net::HTTP.start(link.host) do |http|
    			resp = http.get(link.path)
    			open(folder + filename, "wb") do |file|
    				file.write(resp.body)
	    		end
    		end
    	elsif (link.scheme == "https")
			http = Net::HTTP.new(link.host, 443)
			http.use_ssl = true
			http.verify_mode = OpenSSL::SSL::VERIFY_NONE
			request = Net::HTTP::Get.new(link.path)
			response = http.request(request)
			open(folder + filename, "wb") do |file|
        		file.write(response.body)
    		end
	end
end

def choice(input, link, folder, filename)
	if(input == 'y')
		download(link, folder, filename)
	end
end

header = ""
## INIT ##
puts "Megazord : initialisation de l'exosquelette"
command("git clone https://github.com/lmetdaoui/megazord.git .")

## JQUERY ##
jquery = ''
while(jquery != 'y' && jquery != 'n')
	puts "Force JS : Utilisez-vous JQuery ? (y/n)"
	jquery = STDIN.gets.chomp
end
choice(jquery, "http://code.jquery.com/jquery.min.js", "js/", "jquery.min.js")
if(jquery == 'y')
	then
		header += "<script type='text/javscript' href='js/jquery.min.js'></script>\n"
end

## FANCYBOX ##
popin = ''
while(popin != 'y' && popin != 'n')
	puts "Aurez-vous besoin du laser popin ? (y/n)"
	popin = STDIN.gets.chomp
end
choice(popin, "https://raw.githubusercontent.com/fancyapps/fancyBox/master/source/jquery.fancybox.js", "js/", "jquery.fancybox.js")
choice(popin, "https://raw.githubusercontent.com/fancyapps/fancyBox/master/source/fancybox_sprite.png", "js/", "fancybox_sprite.png")
choice(popin, "https://raw.githubusercontent.com/fancyapps/fancyBox/master/source/fancybox_overlay.png", "js/", "fancybox_overlay.png")
choice(popin, "https://raw.githubusercontent.com/fancyapps/fancyBox/master/source/fancybox_loading.gif", "js/", "fancybox_loading.gif")
choice(popin, "https://raw.githubusercontent.com/fancyapps/fancyBox/master/source/jquery.fancybox.css", "css/", "jquery.fancybox.css")
if(popin == 'y'
)	then
		header += "<script type='text/javscript' href='js/jquery.min.js'></script>\n"
		header += "<link rel='stylesheet' href='css/jquery.fancybox.css'/>\n"
end
puts "Force CSS : initialisation des composants primaires"
command("gem update --system")
command("gem install compass")
puts "Assemblage du Megazord en cours ..."
puts "Ajout des fonctionnalités perfectionnantes"
command("gem install uglifier")
puts "Déclenchement de la phase finale"
command("gem install image-optimizer")
command("gem install filewatcher")
command("gem install yui-compressor")
puts "Vous etes aux commandes."

## SCRIPT TO ADD ##
if(header != "")
	then
		puts "A ajouter entre vos balises <head> : "
		puts header
end
