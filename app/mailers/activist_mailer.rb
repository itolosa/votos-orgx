class ActivistMailer < ApplicationMailer
  default from: "no-responder@example.com"
  layout 'mailer'

  def sample_email (activist)
     @activist = activist
     mail(to: activist.email , subject: 'Votación X')
  end

  def confirmation_email(activist)
  	@activist = activist
    mail(to: activist.email , subject: 'Comprobante de votación')
  end
end

