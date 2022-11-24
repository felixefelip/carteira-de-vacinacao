# == Schema Information
#
# Table name: fabricante_vacinas
#
#  id         :bigint           not null, primary key
#  descricao  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  vacina_id  :integer          not null
#
# Indexes
#
#  index_fabricante_vacinas_on_user_id    (user_id)
#  index_fabricante_vacinas_on_vacina_id  (vacina_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#  fk_rails_...  (vacina_id => vacinas.id)
#
require "test_helper"

class FabricanteVacinaTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
