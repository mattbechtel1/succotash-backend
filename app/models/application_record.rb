class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def slugify(string)
    string.gsub(/[^0-9a-z ]/i, '').downcase.split(' ').join('-')
  end

end
