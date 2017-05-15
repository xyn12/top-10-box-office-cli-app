class Top10BoxOffice::Scraper
	
	def get_page(url)
		Nokogiri::HTML(open('http://www.imdb.com' + url))
	end

	def make_movies
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

end