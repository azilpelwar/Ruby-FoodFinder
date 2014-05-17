require 'restaurant'
class Guide

	class Config
		@@actions=['list','find','add','quit']
		def self.actions; @@actions; end	# ; is used for defining the 'def' at single line
	end
	def initialize(path=nil)			# it is like aconstructor in java
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
			action =get_action
			result = do_action(action)
		end
		conclusion
	end

	def get_action
		action=nil
		#Keep asking for user input until we get a valid action
		until Guide::Config.actions.include?(action)
			puts "Actions: " + Guide::Config.actions.join(", ") if action
			print "> "
			user_response=gets.chomp		#get the user response and chomps the line return from input
			action=user_response.downcase.strip
		end
			return action
	end 

	def do_action(action)
		case action
		when 'list'
			list
		when 'find'
			puts "Finding the items..."
		when 'add'
			add
		when 'quit'
			puts "Quitting..."
			return :quit
		else
			puts "\n Unrecognised Command!!\n"
		end
	end

	def list
		puts "\n Listing restaurants \n".upcase
		restaurants=Restaurant.saved_restaurants
		restaurants.each do |rest|
			puts rest.name + " | " + rest.cuisine + " | " + rest.price 
			
		end
	end

	def add 
		puts "\n Add a restaurant \n \n".upcase
		
		restaurant =Restaurant.build_using_questions

		 if restaurant.save
			puts "\n Restaurant Added \n"
		 else
	 		puts "\n Save Error: Restaurant Not added \n"
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