# == Schema Information
#
# Table name: fabricante_vacinas
#
#  id         :integer          not null, primary key
#  descricao  :string
#  user_id    :integer
#  vacina_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class FabricanteVacinaTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
