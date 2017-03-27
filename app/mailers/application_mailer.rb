class ApplicationMailer < ActionMailer::Base
  default from: "mauricio.delr@example.com"
  layout 'mailer'

  def sample_email (activist)
     @activist = activist
     mail(to: activist.email , subject: 'test mail')
  end

  def confirmation_email (activist)
     @activist = activist
     mail(to: activist.email , subject: 'test mail')
  end
end
