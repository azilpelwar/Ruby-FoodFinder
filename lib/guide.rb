require 'restaurant'
class Guide

	def initialize(path=nil)
			#locate the restraunt text file at path
			Restaurant.filepath = path 

			if Restaurant.file_usable?
				puts "Found Restaurant file."
			#or create a new file
			elsif Restaurant.create_file
				puts "Created restaurant file."
			#exit if create fails	
			else
				puts "Exiting \n \n"
				exit!		#exit the application -ruby command
			end
	end	

	def launch!
		introduction 
		#action loop
		result = nil
		until result == :quit
			# 	what do you want to do? (list, find, add, exit)
			print "> "
			user_response=gets.chomp		#get the user response and chomps the line return from input
			#	do that action
			result = do_action(user_response)
		end
		conclusion
	end

	def do_action(action)
		case action
		when 'list'
			puts "Listing the items..."
		when 'find'
			puts "Finding the items..."
		when 'add'
			puts "Adding the item..."
		when 'quit'
			puts "Quitting..."
			return :quit
		else
			puts "\n Unrecognised Command!!\n"
		end
	end

	def introduction
		puts "\n \n <<<Welcome to the Food Finder >>>>\n \n"
		puts "This is an interactive guide to help you find the food you crave. \n \n"
	end

	def conclusion
		puts "\n Good Bye and Bon Apetit!!!\n"

	end

end