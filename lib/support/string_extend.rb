#This helper is opening up core Ruby String class
#in order to add a new method to all strings

class String 

	#Ruby has a capitalize methos (used below) which 
	# capatalizes the first letter of a string. But in 
	# order to capatalize the first letter of EVERY 
	# word we have to write our own. 
	def titilize
		self.split(' ').collect {|word| word.capitalize}.join(" ")
	end
end
