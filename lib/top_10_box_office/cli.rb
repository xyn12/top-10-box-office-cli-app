class Top10BoxOffice::CLI

  def call
    Top10BoxOffice::Scraper.new.get_movies 
    puts Top10BoxOffice::Movie.date
    start
  end

  def start
    puts "Please enter 'L' to view the list of current movies"
    print "or 'Q' to quit the program: "
    input = gets.chomp
    if input.downcase == "l"
      print_list
      movie_information
    elsif input.downcase == "q"
      puts "Have a great day!"
    else
      start
    end
  end

  def movie_information
    print "Enter movie number for more details [1-10]: "
    input = gets.chomp.to_i
    input.between?(1, 10) ? print_movie_details(input) : movie_information 
  end

  def print_list
    Top10BoxOffice::Movie.all.each.with_index do |movie, idx|
      print " " if idx < 9
      puts "#{idx + 1}. #{movie.title.ljust(35)} #{movie.weekend_total.ljust(10)} #{movie.gross.ljust(10)} #{movie.weeks}"
    end
  end

  def print_movie_details(input)
    movie_details = Top10BoxOffice::Movie.find_or_get_details(input - 1)
    puts "Title: #{movie_details.movie.title}"
    puts "IMDB Rating: #{movie_details.imdb_rating}"
    puts "Stars: #{movie_details.actors}"
    puts "Director: #{movie_details.director}"
    puts "Genre: #{movie_details.genre}"
    puts "Content Rating: #{movie_details.content_rating}"
    puts "Runtime: #{movie_details.runtime}"
    puts "Summary: #{movie_details.summary}"
    puts "\n"
    start
  end

end