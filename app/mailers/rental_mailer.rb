class RentalMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.rental_mailer.confirmation.subject
  #
  def confirmation
    @rental = params[:rental]
    mail to: "felippe.felix98@gmail.com", subject: "Rental Confirmation of TEST"
  end
end
