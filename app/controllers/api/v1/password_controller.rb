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
        if params[:email].blank?
            # No email provided
            render json: { error: "Please provide an e-mail address." }
        end
        if params[:username].blank?
            render json: { error: "Please provide a username." }
        end
        if params[:password].blank?
            render json: { error: "Please provide a password." }
        end
        if params[:password] != params[:confirm_password]
            render json: { error: "Passwords do not match. Please try again."}
        end

        user = User.find_by(reset_password_token: params[:token])
        if user.present? && user.password_token_valid?
            user.update(strong_params)
            byebug
            render json: UserSerializer.new(user).to_serialized_json
        end
    end


    private

    def strong_params
        params.permit(:password, :email)
    end
end
