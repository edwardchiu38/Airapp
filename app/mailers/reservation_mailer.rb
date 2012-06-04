class ReservationMailer < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.reservation_mailer.confirm.subject
  #
  def confirm(new_reservation)
    @reservation = new_reservation
    
    mail to: new_reservation.user.email,
         from: "support@example.com",
         subject: "Thanks for your reservation"
  end
end
