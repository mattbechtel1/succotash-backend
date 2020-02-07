class Api::V1::AuthController < ApplicationController

    def create
        user = User.find_by(username: params[:username])

        if user
            if user.authenticate(params[:password])
                # user found and password authenticated
                token = encode({user_id: user.id})
                render json: { user: UserSerializer.new(user).to_serialized_json, jwt: token }, status: :accepted
            else
                # user found, but bad password
                render json: { error: true, message: "Password does not match. Please try again." }, status: :unauthorized
            end
        else
            # user not found
            render json: { error: true, message: "Username not found." }, status: :unauthorized
        end
    end
end