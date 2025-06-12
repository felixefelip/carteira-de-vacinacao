# typed: true

# == Schema Information
#
# Table name: cadernetas
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#

class User::CadernetaNil < User::Caderneta
  extend T::Sig
end
