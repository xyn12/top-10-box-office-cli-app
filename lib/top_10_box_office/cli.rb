class Top10BoxOffice::CLI

	def call
		Top10BoxOffice::Scraper.new.get_movies 
		start
	end

	def start
		puts Top10BoxOffice::Movie.date

		Top10BoxOffice::Movie.all.each.with_index do |movie, index|
			print " " if index < 9
			puts "#{index + 1}. #{movie.title.ljust(35)} #{movie.weekend_total.ljust(10)} #{movie.gross.ljust(10)} #{movie.weeks}"
		end
	end

end