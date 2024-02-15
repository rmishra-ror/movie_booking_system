require "./source/movie"
require "./source/movie_booking_system"
require "tty-prompt"
@booking_system = MovieBookingSystem.new
@prompt = TTY::Prompt.new

#seed movies
@booking_system.add_movie("Hanu-Man", "Action/Adventure","10:00 - 1:00 PM", 20)
@booking_system.add_movie("Love Aaj Kal", "Romantic", "10:00 AM - 1:00 PM", 20)
@booking_system.add_movie("Hanu-Man", "Action/Adventure", "1:00 PM - 4:00 PM", 10)

puts "Seeded Movies"
@booking_system.display_movies

def book_ticket_interface
  booking_system = @booking_system
  result = @prompt.collect do
    key(:movie_name).select("Select Movie name you wan to book", booking_system.movies.map(&:title).uniq)
    key(:show_timing).select("Select Movie TimeSlot", booking_system.movies.select{|m| m.title == @answers[:movie_name]}.map{ |m| m.show_timing})
  end
  record = booking_system.movies.detect{|m| m.title == result[:movie_name] && m.show_timing == result[:show_timing] }
  no_of_tickets = @prompt.slider("No of Tickets you want to Book", max: record.available_seats, default: 1, help: "(Move arrows left and right to set value)", show_help: :always)
  no_of_tickets.times{ @booking_system.book_ticket(record) }
  puts "\n\n"
end

def cancel_ticket_interface
  booking_system = @booking_system
  result = @prompt.collect do
    key(:movie_name).select("Select Movie name you wan to cancel", booking_system.movies.map(&:title).uniq)
    key(:show_timing).select("Select Movie TimeSlot", booking_system.movies.select{|m| m.title == @answers[:movie_name]}.map{ |m| m.show_timing})
  end
  record = booking_system.movies.detect{|m| m.title == result[:movie_name] && m.show_timing == result[:show_timing] }
  if record.booked_seat_numbers.nil?
    puts "NO bookings are found"
  else
    seat_numbers = @prompt.multi_select("Select seat number you want to cancel", record.booked_seat_numbers, min: 1)
    seat_numbers.each{|seat| booking_system.cancel_ticket(record, seat) }
  end
  puts "\n\n"
end

while(true) do 
  selection = @prompt.select("Select operation", ["Book Ticket", "Cancel Ticket", "Exit"])
  break if selection == "Exit"
  book_ticket_interface if selection == "Book Ticket"
  cancel_ticket_interface if selection ==  "Cancel Ticket"
end
