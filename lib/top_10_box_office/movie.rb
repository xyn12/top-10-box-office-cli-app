class Top10BoxOffice::Movie
	attr_accessor :title, :url, :weekend_total, :gross, :weeks
	@@all = []
	@@date = nil

	def initialize(attributes)
		attributes.each { |key, value| self.send("#{key}=", value)}
		self.class.all << self
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