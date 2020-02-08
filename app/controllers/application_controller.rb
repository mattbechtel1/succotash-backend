class ApplicationController < ActionController::API

    def slugify(string)
        string.gsub(/[^0-9a-z ]/i, '').downcase.split(' ').join('-')
    end

    def secret_key
        Rails.application.secrets.secret_key_base
    end

    # def encode(payload)
    #     JWT.encode(payload, secret_key, "HS512")
    # end

    # def decode(token)
    #     JWT.decode(token, secret_key, true, {algorithm: "HS512"})[0]
    # end

end
