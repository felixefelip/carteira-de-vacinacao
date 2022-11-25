# == Schema Information
#
# Table name: vacinas
#
#  id                :bigint           not null, primary key
#  descricao         :string
#  dias_de_intervalo :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
require "test_helper"

class VacinaTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
