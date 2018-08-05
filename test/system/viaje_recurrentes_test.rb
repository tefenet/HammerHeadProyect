require "application_system_test_case"

class ViajeRecurrentesTest < ApplicationSystemTestCase
  setup do
    @viaje_recurrente = viaje_recurrentes(:one)
  end

  test "visiting the index" do
    visit viaje_recurrentes_url
    assert_selector "h1", text: "Viaje Recurrentes"
  end

  test "creating a Viaje recurrente" do
    visit viaje_recurrentes_url
    click_on "New Viaje Recurrente"

    fill_in "Semanas", with: @viaje_recurrente.semanas
    click_on "Create Viaje recurrente"

    assert_text "Viaje recurrente was successfully created"
    click_on "Back"
  end

  test "updating a Viaje recurrente" do
    visit viaje_recurrentes_url
    click_on "Edit", match: :first

    fill_in "Semanas", with: @viaje_recurrente.semanas
    click_on "Update Viaje recurrente"

    assert_text "Viaje recurrente was successfully updated"
    click_on "Back"
  end

  test "destroying a Viaje recurrente" do
    visit viaje_recurrentes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Viaje recurrente was successfully destroyed"
  end
end
