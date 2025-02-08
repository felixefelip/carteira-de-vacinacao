class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.devise(...)
    super(...)
  end
end
