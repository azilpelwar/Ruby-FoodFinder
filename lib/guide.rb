class Guide

	def initialize(path=nil)
			#locate the restraunt text file at path
			#or create a new file
			#exit if create fails
	end	

	def launch!
		introduction 
		#action loop
		# 	what do you want to do? (list, find, add, exit)
		#	do that action
		#repeat until user quits 
		conclusion
	end

	def introduction
		puts "\n \n <<<Welcome to the Food Finder >>>>\n \n"
		puts "This is an interactive guide to help you find the food you crave. \n \n"
	end

	def conclusion
		puts "\n Good BYe and Bon Apetit!!!\n"
	end

end