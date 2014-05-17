#This module illustrates how additional functionality can be 
#included (or "mixed-in") to a class and then reused.
#Borrows heavily from Ruby on Rails' number _to_currency method

module NumberHelper

def number_to_currency(number,options={})

	unit		= option[:unit]		   || '$'
	precision	= option[:precision]   || 2	
	delimiter	= option[:delimiter]   || ','
	seperator	= option[:seperator]   || '.'

	seperator = '' if precision == 0
	integer, decimal=number.to_s.split('.')

	i =integer.length
	until i<=3
		i-=3
		integer = integer.insert(i,delimiter)
	end

	if precision == 0
		precise_decimal= ''
	else
		#make sure decimal is not nil
		decimal ||="0"
		#make sure the decimal is not too large



end 