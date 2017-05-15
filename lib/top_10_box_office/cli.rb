class Top10BoxOffice::CLI

	def call
		Top10BoxOffice::Scraper.new.make_movies 
		start
	end

	def start
		puts Top10BoxOffice::Movie.date
		Top10BoxOffice::Movie.all.each.with_index do |movie, index|
			puts "#{index + 1}. #{movie.title}"
		end
	end

end