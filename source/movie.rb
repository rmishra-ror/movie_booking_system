class Movie
  attr_accessor :title, :genre, :show_timing, :seats

  def initialize(title, genre, show_timing, total_seats)
    @title = title
    @genre = genre
    @show_timing = show_timing
    @seats = Array.new(total_seats, true) # true indicates available seats
  end

  def available_seats
    @seats.count(true)
  end

  def book_ticket
    if available_seats > 0
      seat_number = @seats.index(true) + 1
      @seats[seat_number - 1] = false # Mark seat as booked
      return seat_number
    else
      return nil
    end
  end

  def cancel_ticket(seat_number)
    @seats[seat_number - 1] = true # Mark seat as available
  end

  def booked_seat_numbers
    return nil if @seats.count(false) == 0
    @seats.each_index.select{|i| @seats[i] == false }.map{|m| m+1 }
  end
end
