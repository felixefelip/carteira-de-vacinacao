# == Schema Information
#
# Table name: user_doses
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  dose_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class UserDose < ApplicationRecord
  belongs_to :user
  belongs_to :dose
end
