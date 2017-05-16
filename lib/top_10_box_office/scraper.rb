class Top10BoxOffice::Scraper
	
	def get_page(url)
		Nokogiri::HTML(open('http://www.imdb.com' + url))
	end

	def get_movies
		doc = get_page('/chart/boxoffice')
		Top10BoxOffice::Movie.set_date(doc.css('div#boxoffice h4').text)

		doc.css('table.chart tbody tr').each do |movie|
			Top10BoxOffice::Movie.new({
				title: movie.css('td.titleColumn a').text,
				url:  movie.css('td.titleColumn a').attribute('href').value,
				weekend_total: movie.css('td.ratingColumn')[0].text.strip,
				gross: movie.css('span.secondaryInfo').text,
				weeks: movie.css('td.weeksColumn').text 
			})
		end
	end

	def get_movie_details(url)
		doc = get_page(url)

		{
			imdb_rating: doc.css('span[itemprop=ratingValue]').text + " / 10",
			actors: doc.css('span[itemprop=actors]').collect { |actor| actor.css('a').text }.join(", "),
			director: doc.css('span[itemprop=director] a').text,
			genre: doc.css('div[itemprop=genre] a').collect { |genre| genre.text.strip }.join(", "),
			content_rating: doc.css('span[itemprop=contentRating]').text,
			runtime: doc.css('time[itemprop=duration]')[1].text,
			summary: doc.css('div.summary_text').text.strip
		}
	end

end


