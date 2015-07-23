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
		if votes.select{|vote| vote.user.female? }.size == nil
			0
		else
			if votes.select{|vote| vote.user.female? }.size == nil
				0
			else
				votes.select{|vote| vote.user.female? }.size
			end
		end
	end

	def male_vote
		if votes.select{|vote| vote.user.male?}.size == nil
			0
		else
			votes.select{|vote| vote.user.male?}.size
		end
	end

	def under_twenty_vote
		 if votes.select{|vote| vote.user.age == nil }.size
		 	0
		else
		 votes.select{|vote| vote.user.age < 20  }.size
		end
	end

	def twenty_one_forty_vote
		if votes.select{|vote| vote.user.age == nil }.size
			0
		else
			votes.select{|vote| vote.user.age <= 40  }.size
		end
	end

	def forty_one_sixty_vote
		if votes.select{|vote| vote.user.age == nil }.size
			0
		else
			votes.select{|vote| vote.user.age < 60  }.size
		end
	end

	def sixty_eighty_vote
		if votes.select{|vote| vote.user.age == nil }.size
			0
		else
			votes.select{|vote| vote.user.age < 80  }.size
		end
	end

	def thin_vote
		if votes.select{|vote| vote.user.body_type == "thin"  }.size == nil
			0
		else
			votes.select{|vote| vote.user.body_type == "thin"  }.size
		end
	end

	def medium_vote
		if votes.select{|vote| vote.user.body_type == "medium"  }.size == nil
			0
		else
			votes.select{|vote| vote.user.body_type == "medium"  }.size
		end
	end

	def large_vote
		if votes.select{|vote| vote.user.body_type == "large"  }.size == nil
			0
		else
			votes.select{|vote| vote.user.body_type == "large"  }.size
		end
	end

	def female_under_20_vote
		if votes.select{|vote| vote.user.female? && vote.user.age == nil}.size
			0
		else
			votes.select{|vote| vote.user.female? && vote.user.age < 20}.size
		end

	end

	def male_under_20_vote
		if votes.select{|vote| vote.user.male? && vote.user.age == nil}.size
			0
		else
			votes.select{|vote| vote.user.male? && vote.user.age < 20}.size
		end
	end

	def female_21_40_vote
		if votes.select{|vote| vote.user.female? && vote.user.age == nil}.size
			0
		else
			votes.select{|vote| vote.user.female? && vote.user.age <= 40}.size
		end
	end

	def male_21_40_vote
		if votes.select{|vote| vote.user.male? && vote.user.age == nil}.size
			0
		else
			votes.select{|vote| vote.user.male? && vote.user.age <= 40}.size
		end
	end

	def female_41_60_vote
		if votes.select{|vote| vote.user.female? && vote.user.age == nil}.size
			0
		else
			votes.select{|vote| vote.user.female? && vote.user.age <= 60}.size
		end
	end

	def male_41_60_vote
		if votes.select{|vote| vote.user.male? && vote.user.age == nil }.size
			0
		else
			votes.select{|vote| vote.user.male? && vote.user.age <= 60}.size
		end
	end

	def female_61_80_vote
			if votes.select{|vote| vote.user.female? && vote.user.age == nil }.size
				0
			else
				votes.select{|vote| vote.user.female? && vote.user.age <= 80}.size
			end
	end

	def male_61_80_vote
			if votes.select{|vote| vote.user.male? && vote.user.age == nil}.size
				0
			else
				votes.select{|vote| vote.user.male? && vote.user.age <= 80}.size
			end
	end


	def female_percentage
		if ((female_vote.to_f / vote_count.to_f) * 100).floor == nil
			0
		else
			((female_vote.to_f / vote_count.to_f) * 100).floor
		end
	end

	def male_percentage
		if ((male_vote.to_f / vote_count.to_f) * 100).floor == nil
			0
		else
			((male_vote.to_f / vote_count.to_f) * 100).floor
		end
	end

	def under_twenty_percentage
		if ((under_twenty_vote.to_f / vote_count.to_f) * 100).floor == nil
			0
		else
			((under_twenty_vote.to_f / vote_count.to_f) * 100).floor
		end
	end

	def twenty_one_forty_percentage
		if ((twenty_one_forty_vote.to_f / vote_count.to_f) * 100).floor == nil
			0
		else
			((twenty_one_forty_vote.to_f / vote_count.to_f) * 100).floor
		end
	end

	def forty_one_sixty_percentage
		if ((forty_one_sixty_vote.to_f / vote_count.to_f) * 100).floor == nil
			0
		else
			((forty_one_sixty_vote.to_f / vote_count.to_f) * 100).floor
		end
	end

	def sixty_eighty_percentage
		if ((sixty_eighty_vote.to_f / vote_count.to_f) * 100).floor == nil
			0
		else
			((sixty_eighty_vote.to_f / vote_count.to_f) * 100).floor
		end
	end

	def thin_percentage
		if ((thin_vote.to_f / vote_count.to_f) * 100).floor == nil
			0
		else
			((thin_vote.to_f / vote_count.to_f) * 100).floor
		end
	end

	def medium_percentage
		if ((medium_vote.to_f / vote_count.to_f) * 100).floor == nil
			0
		else
			((medium_vote.to_f / vote_count.to_f) * 100).floor
		end
	end

	def large_percentage
		if ((large_vote.to_f / vote_count.to_f) * 100).floor == nil
			0
		else
			((large_vote.to_f / vote_count.to_f) * 100).floor
		end
	end

	def female_under_20_percentage
		if ((female_under_20_vote.to_f / vote_count.to_f) * 100).floor == nil
			0
		else
			((female_under_20_vote.to_f / vote_count.to_f) * 100).floor
		end
	end

	def male_under_20_percentage
		if ((male_under_20_vote.to_f / vote_count.to_f) * 100).floor == nil
			0
		else
			((male_under_20_vote.to_f / vote_count.to_f) * 100).floor
		end
	end

	def female_21_40_percentage
		if ((female_21_40_vote.to_f / vote_count.to_f) * 100).floor == nil
			0
		else
			((female_21_40_vote.to_f / vote_count.to_f) * 100).floor
		end
	end

	def male_21_40_percentage
		if ((male_21_40_vote.to_f / vote_count.to_f) * 100).floor == nil
			0
		else
			((male_21_40_vote.to_f / vote_count.to_f) * 100).floor
		end
	end

	def female_41_60_percentage
		if ((female_41_60_vote.to_f / vote_count.to_f) * 100).floor == nil
			0
		else
			((female_41_60_vote.to_f / vote_count.to_f) * 100).floor
		end
	end

	def male_41_60_percentage
		if ((male_41_60_vote.to_f / vote_count.to_f) * 100).floor == nil
			0
		else
			((male_41_60_vote.to_f / vote_count.to_f) * 100).floor
		end
	end

	def female_61_80_percentage
		if ((female_61_80_vote.to_f / vote_count.to_f) * 100).floor == nil
			0
		else
			((female_61_80_vote.to_f / vote_count.to_f) * 100).floor
		end
	end

	def male_61_80_percentage
		if ((male_61_80_vote.to_f / vote_count.to_f) * 100).floor == nil
			0
		else
			((male_61_80_vote.to_f / vote_count.to_f) * 100).floor
		end
	end

end
