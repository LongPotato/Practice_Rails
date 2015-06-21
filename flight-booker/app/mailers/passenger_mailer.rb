class PassengerMailer < ApplicationMailer
  default from: 'flightbooker@example.com'

  def confirm_email(passenger)
    @passenger = passenger
    @booking = passenger.bookings.last
    @url  = "http://localhost:3000/bookings/#{@booking.id}"
    mail(to: passenger.email, subject: "Flight Booking Confirmation ##{@booking.id}")
  end
end
