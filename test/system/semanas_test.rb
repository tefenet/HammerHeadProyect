require "application_system_test_case"

class SemanasTest < ApplicationSystemTestCase
  setup do
    @semana = semanas(:one)
  end

  test "visiting the index" do
    visit semanas_url
    assert_selector "h1", text: "Semanas"
  end

  test "creating a Semana" do
    visit semanas_url
    click_on "New Semana"

    fill_in "Viaje Recurrentes", with: @semana.viaje_recurrentes_id
    click_on "Create Semana"

    assert_text "Semana was successfully created"
    click_on "Back"
  end

  test "updating a Semana" do
    visit semanas_url
    click_on "Edit", match: :first

    fill_in "Viaje Recurrentes", with: @semana.viaje_recurrentes_id
    click_on "Update Semana"

    assert_text "Semana was successfully updated"
    click_on "Back"
  end

  test "destroying a Semana" do
    visit semanas_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Semana was successfully destroyed"
  end
end
