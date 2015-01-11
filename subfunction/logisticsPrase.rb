isWeightSection = false
typeA = ""
typeB = ""
feature =""
dirName = "weights"
@resultfile = File.open("#{dirName}/tempFile", "w")
string1 =""
string2 =""
File.open(ARGV[0]).each_line{ |line| 
	if line.length > 2
		temp = /\[(?<typeA>[0-9]+)\] \* (?<feature>[0-9\.\-]+)/.match(line)
		if !temp.nil?
			string1 << "#{temp["typeA"]},"
			string2 << "#{temp["feature"]},"
		end
	else
		@resultfile.write("[#{string1}]\n[#{string2}]\n")
		string1 =""
		string2 =""
	end
	# if( line.match("Classifier for classes") )
	# 	puts line
	# end
}