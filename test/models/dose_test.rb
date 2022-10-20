# == Schema Information
#
# Table name: doses
#
#  id               :integer          not null, primary key
#  tipo             :string
#  data_vacinacao   :date
#  lote_numero      :string
#  vacinador_codigo :string
#  local_codigo     :string
#  vacina_id        :integer          not null
#  user_id          :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
require "test_helper"

class DoseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
