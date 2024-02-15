RSpec.describe MovieBookingSystem do
  let(:booking_system) { MovieBookingSystem.new }

  describe "#add_movie" do
    it "adds a movie to the system" do
      booking_system.add_movie("Bhahubali", "Action", "10:00 AM - 1:00 PM", 20)
      expect(booking_system.movies.count).to eq(1)
    end
  end

  describe "#book_ticket" do
    it "books a ticket for the specified movie and show timing" do
      booking_system.add_movie("Bhahubali", "Action", "10:00 AM - 1:00 PM", 20)
      expect { booking_system.book_ticket(1) }.to output(/Ticket booked successfully/).to_stdout
    end
  end

  describe "#cancel_ticket" do
    it "cancels the booked ticket for the specified movie, show timing, and seat number" do
      booking_system.add_movie("Bhahubali", "Action", "10:00 AM - 1:00 PM", 20)
      seat_number = booking_system.movies[0].book_ticket
      expect { booking_system.cancel_ticket(1, seat_number) }.to output(/Ticket canceled successfully/).to_stdout
    end
  end
end

