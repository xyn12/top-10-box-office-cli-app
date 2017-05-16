class Top10BoxOffice::Movie
	attr_accessor :title, :url, :weekend_total, :gross, :weeks, :movie_details
	@@all = []
	@@date = nil

	def initialize(attributes)
		attributes.each { |key, value| self.send("#{key}=", value)}
		self.class.all << self
	end

	def get_details
		movie_profile = Top10BoxOffice::MovieDetails.new(Top10BoxOffice::Scraper.new.get_movie_details(url))
		movie_profile.movie = self
		movie_profile
	end

	def self.find_or_get_details(idx)
		self.all[idx].movie_details ||= self.all[idx].get_details
	end

	def self.set_date(date)
		@@date = date
	end

	def self.date
		@@date
	end

	def self.all
		@@all
	end

end