require 'test_helper'

class SemanasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @semana = semanas(:one)
  end

  test "should get index" do
    get semanas_url
    assert_response :success
  end

  test "should get new" do
    get new_semana_url
    assert_response :success
  end

  test "should create semana" do
    assert_difference('Semana.count') do
      post semanas_url, params: { semana: { viaje_recurrentes_id: @semana.viaje_recurrentes_id } }
    end

    assert_redirected_to semana_url(Semana.last)
  end

  test "should show semana" do
    get semana_url(@semana)
    assert_response :success
  end

  test "should get edit" do
    get edit_semana_url(@semana)
    assert_response :success
  end

  test "should update semana" do
    patch semana_url(@semana), params: { semana: { viaje_recurrentes_id: @semana.viaje_recurrentes_id } }
    assert_redirected_to semana_url(@semana)
  end

  test "should destroy semana" do
    assert_difference('Semana.count', -1) do
      delete semana_url(@semana)
    end

    assert_redirected_to semanas_url
  end
end
