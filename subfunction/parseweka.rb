isWeightSection = false
typeA = ""
typeB = ""
dirName = "weights"

File.open(ARGV[0]).each_line{ |line| 
	if line.split != ""
		
		if isWeightSection == true
			temp = /(?<weight>[0-9\-\.]+) \* \(normalized\) (?<feature>[a-zA-Z0-9]+)/.match(line)
			if !temp.nil?
				@resultfile.write("#{temp["feature"]}\t#{temp["weight"]}\n")
				
			elsif line.match("Number of kernel evaluations")
				puts "#{typeA}_#{typeB}"
				isWeightSection = false
				@resultfile.close
			end
			

			
		else
			# puts line
			temp = /Classifier for classes: (?<typeA>[A-Za-z]+), (?<typeB>[A-Za-z]+)/.match(line)
		    unless temp.nil?
		    	typeA = temp["typeA"]
		    	typeB = temp["typeB"]
				isWeightSection = true
				unless File.directory?(dirName)
					Dir.mkdir(dirName)
				end
		    	@resultfile = File.open("#{dirName}/#{typeA}_#{typeB}", "w")
		    end
		    
		end
	end

	# if( line.match("Classifier for classes") )
	# 	puts line
	# end
}