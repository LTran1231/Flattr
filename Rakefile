# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

namespace :vote do 
	task :finish => :environment do
		# desc "find all votes with expired time limit"
	  
		past_photos = Photo.all.select { |photo| photo.expired_date.past? }
		past_photos.each { |photo| photo.completed = true; photo.save! }
	end
end
