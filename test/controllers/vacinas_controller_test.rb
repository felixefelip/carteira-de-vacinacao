require "test_helper"

class VacinasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @vacina = vacinas(:one)
  end

  test "should get index" do
    get vacinas_url
    assert_response :success
  end

  test "should get new" do
    get new_vacina_url
    assert_response :success
  end

  test "should create vacina" do
    assert_difference('Vacina.count') do
      post vacinas_url, params: { vacina: { descricao: @vacina.descricao } }
    end

    assert_redirected_to vacina_url(Vacina.last)
  end

  test "should show vacina" do
    get vacina_url(@vacina)
    assert_response :success
  end

  test "should get edit" do
    get edit_vacina_url(@vacina)
    assert_response :success
  end

  test "should update vacina" do
    patch vacina_url(@vacina), params: { vacina: { descricao: @vacina.descricao } }
    assert_redirected_to vacina_url(@vacina)
  end

  test "should destroy vacina" do
    assert_difference('Vacina.count', -1) do
      delete vacina_url(@vacina)
    end

    assert_redirected_to vacinas_url
  end
end
