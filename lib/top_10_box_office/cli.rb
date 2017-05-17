class Top10BoxOffice::CLI

  def call
    Top10BoxOffice::Scraper.new.get_movies 
    puts "----------------------------------------------------------------------------"
    puts "                     #{Top10BoxOffice::Movie.date}                          ".light_green
    puts "----------------------------------------------------------------------------"
    puts
    start
  end

  def start
    puts "Please enter a command:".light_green
    puts " - 'list' to view a list top box office movies"
    puts " - 'quit' to quit the program"
    print "\n['L'ist / 'Q'uit] $ ".light_red
    input = gets.chomp.downcase
    puts
    if input == "l" || input == "list"
      print_list
      movie_information
    elsif input.downcase == "q"
      puts "Have a great day!\n".light_magenta
    else
      start
    end
  end

  def movie_information
    puts "\nEnter movie number for more details:".light_green
    print "[1 - 10] $ ".light_red
    input = gets.chomp.to_i
    input.between?(1, 10) ? print_movie_details(input) : movie_information 
  end

  def print_list
    puts "               Title                     Weekend         Gross         Weeks".light_green
    puts
    Top10BoxOffice::Movie.all.each.with_index do |movie, idx|
      print " " if idx < 9
      puts "#{idx + 1}.  #{movie.title.ljust(35)} #{movie.weekend_total.ljust(15)} #{movie.gross.ljust(15)} #{movie.weeks}"
    end
  end

  def print_movie_details(input)
    movie_details = Top10BoxOffice::Movie.find_or_get_details(input - 1)
    puts "\nTitle:".light_blue + " #{movie_details.movie.title}"
    puts "IMDB Rating:".light_blue + "  #{movie_details.imdb_rating}"
    puts "Stars:".light_blue + "  #{movie_details.actors}"
    puts "Director:".light_blue + "  #{movie_details.director}"
    puts "Genre:".light_blue + "  #{movie_details.genre}"
    puts "Content Rating:".light_blue + "  #{movie_details.content_rating}"
    puts "Runtime:".light_blue + "  #{movie_details.runtime}"
    puts "Summary:".light_blue + "  #{movie_details.summary}"
    puts "\n"
    start
  end
end