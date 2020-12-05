class Api::V1::PasswordController < ApplicationController

    def forgot
        if params[:email].blank?
            # No email provided
            render json: { error: "Please provide an e-mail address."} 
        else
            user = User.find_by(email: params[:email])
            if user.present?
                user.generate_password_token!
                UserMailer.password_reset_email(user).deliver_now
                render json: { message: "Password reset email has been sent to #{params[:email]}"}
            else
                render json: { error: "Email address not found." }
            end
        end
    end

    def reset
    end
end
