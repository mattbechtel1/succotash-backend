class UserMailer < ApplicationMailer

    def password_reset_email user
        @user = user
        mail(to: @user.email, subject: "Your password reset instructions are inside")
    end
end
