class UserMailer < ActionMailer::Base

  default from:

  def contact_us_email(contact)
    @contact = contact
    mail to:"Judiyew@YKG.com",subject:'New Contact'
  end
end