class PhotoRatingCalculator

	def self.call(*args)
		new.call(*args)
	end

	KEYS = %w{
		photo
		vote_count
		vote
		like_votes
		rating_saying
		female_percentage
		male_percentage
		under_twenty_percentage
		twenty_one_forty_percentage
		forty_one_sixty_percentage
		sixty_eighty_percentage
		thin_percentage
		medium_percentage
		large_percentage
		female_under_20_percentage
		male_under_20_percentage
		female_21_40_percentage
		male_21_40_percentage
		female_41_60_percentage
		male_41_60_percentage
		female_61_80_percentage
		male_61_80_percentage
		female_vote
		male_vote
		under_twenty_vote
		twenty_one_forty_vote
		forty_one_sixty_vote
		sixty_eighty_vote
		thin_vote
		medium_vote
		large_vote
		female_under_20_vote
		male_under_20_vote
		female_21_40_vote
		male_21_40_vote
		female_41_60_vote
		male_41_60_vote
		female_61_80_vote
		male_61_80_vote
	}

	def call(photo)
		@photo = photo

		KEYS.inject({}) do |hash, key|
			hash.update key => send(key)
		end
	end

	private

	attr_reader :photo

	def vote_count
		@vote_count ||= @photo.votes.count
	end

	def votes
		@photo.votes.includes(:user)
	end
	alias_method :vote, :votes

	def like_votes
		@like_votes ||= @photo.votes.liked.count
	end

	def total_votes_count
		@total_votes_count ||= votes.size
	end

	def liked_votes_count
		@liked_votes_count ||= @photo.votes.liked.count
	end

	def percentage_rating
    @percentage_rating ||= begin
    	total_votes_count.zero? ? 0 : (liked_votes_count.to_f / total_votes_count.to_f) * 100
    end
	end

	def rating_saying
		@rating_saying ||= case
			when percentage_rating >= 90; "Smokin!!"
	    when percentage_rating >= 80; "Super Flattering"
	    when percentage_rating >= 70; "So Flattering"
	    when percentage_rating >= 60; "Flattering"
	    when percentage_rating >= 50; "Kind of Flattering"
	    else; "Not Doing You Justice"
    end
	end



	def female_vote
		votes.select{|vote| vote.user.female? }.size
	end

	def male_vote
		votes.select{|vote| vote.user.male?}.size
	end

	def under_twenty_vote
		 votes.select{|vote| vote.user.age < 20  }.size
	end

	def twenty_one_forty_vote
		votes.select{|vote| vote.user.age <= 40  }.size
	end

	def forty_one_sixty_vote
		votes.select{|vote| vote.user.age < 60  }.size
	end

	def sixty_eighty_vote
		votes.select{|vote| vote.user.age < 80  }.size
	end

	def thin_vote
		votes.select{|vote| vote.user.body_type == "thin"  }.size
	end

	def medium_vote
		votes.select{|vote| vote.user.body_type == "medium"  }.size
	end

	def large_vote
		votes.select{|vote| vote.user.body_type == "large"  }.size
	end

	def female_under_20_vote
		votes.select{|vote| vote.user.female? && vote.user.age < 20}.size

	end

	def male_under_20_vote
		votes.select{|vote| vote.user.male? && vote.user.age < 20}.size
	end

	def female_21_40_vote
		votes.select{|vote| vote.user.female? && vote.user.age <= 40}.size
	end

	def male_21_40_vote
		votes.select{|vote| vote.user.male? && vote.user.age <= 40}.size
	end

	def female_41_60_vote
		votes.select{|vote| vote.user.female? && vote.user.age <= 60}.size
	end

	def male_41_60_vote
		votes.select{|vote| vote.user.male? && vote.user.age <= 60}.size
	end

	def female_61_80_vote
			votes.select{|vote| vote.user.female? && vote.user.age <= 80}.size
	end

	def male_61_80_vote
			votes.select{|vote| vote.user.male? && vote.user.age <= 80}.size
	end


	def female_percentage
		((female_vote.to_f / vote_count.to_f) * 100).floor
	end

	def male_percentage
		((male_vote.to_f / vote_count.to_f) * 100).floor
	end

	def under_twenty_percentage
		((under_twenty_vote.to_f / vote_count.to_f) * 100).floor
	end

	def twenty_one_forty_percentage
		((twenty_one_forty_vote.to_f / vote_count.to_f) * 100).floor
	end

	def forty_one_sixty_percentage
		((forty_one_sixty_vote.to_f / vote_count.to_f) * 100).floor
	end

	def sixty_eighty_percentage
		((sixty_eighty_vote.to_f / vote_count.to_f) * 100).floor
	end

	def thin_percentage
		((thin_vote.to_f / vote_count.to_f) * 100).floor
	end

	def medium_percentage
		((medium_vote.to_f / vote_count.to_f) * 100).floor
	end

	def large_percentage
		((large_vote.to_f / vote_count.to_f) * 100).floor
	end

	def female_under_20_percentage
		((female_under_20_vote.to_f / vote_count.to_f) * 100).floor
	end

	def male_under_20_percentage
		((male_under_20_vote.to_f / vote_count.to_f) * 100).floor
	end

	def female_21_40_percentage
		((female_21_40_vote.to_f / vote_count.to_f) * 100).floor
	end

	def male_21_40_percentage
		((male_21_40_vote.to_f / vote_count.to_f) * 100).floor
	end

	def female_41_60_percentage
		((female_41_60_vote.to_f / vote_count.to_f) * 100).floor
	end

	def male_41_60_percentage
		((male_41_60_vote.to_f / vote_count.to_f) * 100).floor
	end

	def female_61_80_percentage
		((female_61_80_vote.to_f / vote_count.to_f) * 100).floor
	end

	def male_61_80_percentage
		((male_61_80_vote.to_f / vote_count.to_f) * 100).floor
	end

end
