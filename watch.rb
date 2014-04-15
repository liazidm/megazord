## author : Liazid METDAOUI ##

 #!/usr/bin/ruby
require "yui/compressor"
require 'filewatcher'

## returns filename with "min" ##
def minfilename(file_input)
	pathExplode = file_input.split('/')
    file = pathExplode[2].split('.')
    length = file.size
    if(!file.include?('min'))
	    file[length-1] = "min.js"
	end
	outputfile = file.join(".")
    return outputfile
end
## Compass watch ##
compass = Thread.new {
	system("compass watch --debug-info")
	Thread.pass
}
## JavaScript watch ##
compressor = YUI::JavaScriptCompressor.new
FileWatcher.new(["js/*.js"]).watch() do |filename, event|
 	if(event == :changed)
  	  puts "File updated: " + filename
  	  outputfile = minfilename(filename)
  	  inputfile = File.open(filename, 'r') 
  	  File.open("js.min/" + outputfile , 'w') {|f| f.write(compressor.compress(inputfile.read)) }
	end
	if(event == :new)
  	  puts "File created: " + filename
  	  outputfile = minfilename(filename)
  	  inputfile = File.open(filename, 'r') 
  	  File.open("js.min/" + outputfile , 'w') {|f| f.write(compressor.compress(inputfile.read)) }
	end
end

