class Top10BoxOffice::MovieDetails
	attr_accessor :movie, :imdb_rating, :actors, :director, :genre, :content_rating, :runtime, :summary
	@@all = []

	def initialize(attributes)
		attributes.each { |key, value| self.send("#{key}=", value) }
		self.class.all << self
	end

	def self.all
		@@all
	end

end