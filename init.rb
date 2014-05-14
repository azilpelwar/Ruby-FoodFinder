######Food Finder ########
#
#
# Launch this ruby file from the command line tto start the 
# application.
#
#
APP_ROOT=File.dirname(__FILE__)

#Option1
#require "#{APP_ROOT}/lib/guide"

#Option2 for OS independant path seperators
#require File.join(APP_ROOT,'lib','guide.rb')

#Option3 (Advanced way) -created the array with all the folders to be asked ruby to 
#look at and search the specified file i.e. here "guide.rb"  
$:.unshift(File.join(APP_ROOT,'lib'))
require 'guide'
