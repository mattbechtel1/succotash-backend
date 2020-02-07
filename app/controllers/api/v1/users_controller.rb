class Api::V1::UsersController < ApplicationController

    def create
        user = User.create(strong_params)

        if user.valid?
            @token = encode(user_id: user.id)
            user_serial = UserSerializer.new(user).to_serialized_json
            render json: {user: user_serial, jwt: @token}, status: :created
        else
            render json: { error: 'Username invalid. Please try another username.' }, status: :not_acceptable
        end

    end

    def profile
        token = request.headers["Authentication"]
        payload = decode(token)
        user = User.find(payload["user_id"])
        render json: UserSerializer.new(user).to_serialized_json
    end

    private

    def strong_params
        params.require(:user).permit(:username, :password, :pic)
    end
end
