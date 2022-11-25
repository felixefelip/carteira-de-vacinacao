# == Schema Information
#
# Table name: recomendacao_vacinals
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_recomendacao_vacinals_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class RecomendacaoVacinalTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
