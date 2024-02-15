  RSpec.describe Movie do
    let(:movie) { Movie.new("Bhahubali", "Action", "10:00 AM - 1:00 PM", 20) }
  
    describe "#available_seats" do
      it "returns the number of available seats for a given show timing" do
        expect(movie.available_seats).to eq(20)
      end
    end
  
    describe "#book_ticket" do
      it "books a ticket for the given show timing and returns the seat number" do
        expect(movie.book_ticket).to be_between(1, 20)
      end
    end
  
    describe "#cancel_ticket" do
      it "cancels the booked ticket for the given seat number" do
        seat_number = movie.book_ticket
        movie.cancel_ticket(seat_number)
        expect(movie.available_seats).to eq(20)
      end
    end
  end
  
