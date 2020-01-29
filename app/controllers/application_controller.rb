class ApplicationController < ActionController::API

    def slugify(string)
        string.gsub(/[^0-9a-z ]/i, '').downcase.split(' ').join('-')
    end

end
