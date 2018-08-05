require 'test_helper'

class ViajeRecurrentesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @viaje_recurrente = viaje_recurrentes(:one)
  end

  test "should get index" do
    get viaje_recurrentes_url
    assert_response :success
  end

  test "should get new" do
    get new_viaje_recurrente_url
    assert_response :success
  end

  test "should create viaje_recurrente" do
    assert_difference('ViajeRecurrente.count') do
      post viaje_recurrentes_url, params: { viaje_recurrente: { semanas: @viaje_recurrente.semanas } }
    end

    assert_redirected_to viaje_recurrente_url(ViajeRecurrente.last)
  end

  test "should show viaje_recurrente" do
    get viaje_recurrente_url(@viaje_recurrente)
    assert_response :success
  end

  test "should get edit" do
    get edit_viaje_recurrente_url(@viaje_recurrente)
    assert_response :success
  end

  test "should update viaje_recurrente" do
    patch viaje_recurrente_url(@viaje_recurrente), params: { viaje_recurrente: { semanas: @viaje_recurrente.semanas } }
    assert_redirected_to viaje_recurrente_url(@viaje_recurrente)
  end

  test "should destroy viaje_recurrente" do
    assert_difference('ViajeRecurrente.count', -1) do
      delete viaje_recurrente_url(@viaje_recurrente)
    end

    assert_redirected_to viaje_recurrentes_url
  end
end
