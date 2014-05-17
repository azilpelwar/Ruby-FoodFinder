class Restaurant

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
		#read teh restaurant file 
		#return the instances of restaurant
	end

	def save
		return false unless Restaurant.file_usable?
		File.open(@@filepath,'a') do |file|
			file.puts "#{[@name, @cuisine, @price].join("\t")}\n"
		end
		return true
	end

end