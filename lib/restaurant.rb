require 'support/number_helper'
class Restaurant

	include NumberHelper 

	@@filepath=nil

	# "self." methods are the class methods i.e. accessible via class name [static method] 

	def self.filepath=(path=nil)	#setter method for filepath variable
		@@filepath =File.join(APP_ROOT,path)

	end
	attr_accessor :name, :cuisine, :price	#accessor internally creates the getter and setter defs for given vars

	def self.file_exists?
		#class should know if the restaurant file file_exists
		if @@filepath && File.exists?(@@filepath)
			return true
		else
			return false
		end
	end

	def self.file_usable?

		return false unless @@filepath
		return false unless File.exists?(@@filepath)
		return false unless File.readable?(@@filepath)
		return false unless File.writable?(@@filepath)
		return true

	end


	def self.create_file
		#create a restaurant file
		File.open(@@filepath,'w') unless file_exists?
		return file_usable?
	end

	def self.saved_restaurants
		restaurants=[]
		if file_usable?
			file=File.new(@@filepath,'r')
			file.each_line do |line|
				restaurants << Restaurant.new.import_line(line.chomp)
			end
		end
		file.close
		return restaurants
	end

	def self.build_using_questions
		args={}
		print "Restaurant Name: "
		args[:name] = gets.chomp.strip

		print "Cuisine Type: "
		args[:cuisine] = gets.chomp.strip

		print "Average Price: "
		args[:price] = gets.chomp.strip

		return self.new(args)
	
	end



	def initialize(args={})		#it is like a constructor in java
		@name    = args[:name]    || ""
		@cuisine = args[:cuisine] || ""
		@price   = args[:price]   || ""
	end

	def import_line(line)
		line_array=line.split("\t")
		@name, @cuisine, @price=line_array			#assigns the [0]th value to name,[1]th value to cuisine and [2]nd value to price
		return self				#this is IMP to return the object, if we dont return then it wont get assigned into method call obejct[Observe the def call to understand] 
	end
	 
	def save
		return false unless Restaurant.file_usable?
		File.open(@@filepath,'a') do |file|
			file.puts "#{[@name, @cuisine, @price].join("\t")}\n"
		end
		return true
	end

	def formatted_price
		number_to_currency(@price)
	end



end