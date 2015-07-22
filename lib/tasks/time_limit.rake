require 'active_support'

task :finished => :environment do
	desc "find all votes with expired time limit"
	current_time = Time.now
  
	Photo.all.select{ |photo| photo.completed = true if photo.expired_date.past? }
end
	
# add to the photo class a method for checking if expired?
# 

# 1) 
	
