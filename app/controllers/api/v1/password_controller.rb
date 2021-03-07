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

        user = User.find_by(reset_password_token: params[:token], username: params[:username], email: params[:email])
        if user.present? && user.password_token_valid?
            user.update(strong_params)
            @token = encode(user_id: user.id)
            render json: { user: UserSerializer.new(user).to_serialized_json, jwt: @token, message: "Password successfully reset. Happy harvesting!" }, status: :accepted
        else
            render json: { error: "User not found. Please make sure the username and email match and try again." }
        end
    end


    private

    def strong_params
        params.permit(:password, :email)
    end
end
