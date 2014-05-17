require 'restaurant'
require 'support/string_extend'
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
			action, args =get_action
			result = do_action(action, args)
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
			args=user_response.downcase.strip.split(' ')
			action =args.shift 				#"shift" removes the first element from the array
		end
			return action, args				#even if it return 2 values, ruby internally converts the 2 retun values to the array and then returns
	end 

	def do_action(action, args=[])
		case action
		when 'list'
			list
		when 'find'
			keyword = args.shift
			find(keyword)
		when 'add'
			add
		when 'quit'
			puts "Quitting..."
			return :quit
		else
			puts "\n Unrecognised Command!!\n"
		end
	end

	def find(keyword="")
		output_action_header ("Find a restaurant")
		if keyword 
			#search
			restaurants = Restaurant.saved_restaurants
			found=restaurants.select do |rest|
				rest.name.downcase.include?(keyword.downcase) || 
				rest.cuisine.downcase.include?(keyword.downcase) || 
				rest.price.to_i <= keyword.to_i
			end
			output_restaurant_table (found)
		else
			puts "Find using a key pharse to search the restaurant list."
			puts "Exs. 'find tamale', 'find indian' \n\n"
		end
	end

	def list
		output_action_header("Listing restaurants")
		restaurants=Restaurant.saved_restaurants
		output_restaurant_table(restaurants) 
	end

	def add 
		output_action_header( "Add a restaurant")
		
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


	private 


	def output_action_header(text)
		puts "\n #{text.upcase.center(60)}\n\n"
	end


	def output_restaurant_table(restaurants=[])
		print " " + "Name".ljust(30)
		print " " + "Cusine".ljust(20)
		print " " + "Price".rjust(6) + "\n"
		puts "-" * 60
		restaurants.each do |rest|
			line= " " << rest.name.titilize.ljust(30)
			line << " " + rest.cuisine.titilize.ljust(20)
			line << " " + rest.formatted_price.rjust(6)
			puts line	
		end
		puts "No listings found" if restaurants.empty?
		puts "-" * 60	
	end

end