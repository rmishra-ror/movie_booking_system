class MovieBookingSystem
    attr_accessor :movies
  
    def initialize
      @movies = []
    end
  
    def add_movie(title, genre, show_timing, total_seats)
      @movies << Movie.new(title, genre, show_timing, total_seats)
    end
  
    def display_movies
      @movies.each_with_index do |movie, index|
        puts "#{index + 1}. #{movie.title} (#{movie.genre})"
        puts "   Show Timing: #{movie.show_timing}"
        puts "   Available Seats: #{movie.seats.count(true)}"
      end
    end

    def movie_by_index(movie_index)
      movie = @movies[movie_index - 1]
    end
    
    def book_ticket(movie)
      movie = movie_by_index(movie) unless movie.is_a?(Movie)
      seat_number = movie.book_ticket
      if seat_number
        puts "Ticket booked successfully for #{movie.title} at #{movie.show_timing}. Seat number: #{seat_number}"
      else
        puts "Sorry, no available seats for #{movie.title} at #{movie.show_timing}."
      end
    end
  
    def cancel_ticket(movie, seat_number)
      movie = movie_by_index(movie) unless movie.is_a?(Movie)
      movie.cancel_ticket(seat_number)
      puts "Ticket canceled successfully for #{movie.show_timing}, seat number: #{seat_number}"
    end
  end
  