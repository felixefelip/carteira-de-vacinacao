class UserDose < ApplicationRecord
  belongs_to :user
  belongs_to :dose
end
