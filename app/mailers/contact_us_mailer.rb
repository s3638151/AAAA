class ContactUsMailer < ApplicationMailer
    def contactus(name, message)
        @name = name
        @message = message
        mail(to: "s3638151@student.rmit.edu.au", subject: "Rad")
    end
end
