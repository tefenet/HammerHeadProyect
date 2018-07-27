require "application_system_test_case"

class ScoresTest < ApplicationSystemTestCase
  setup do
    @score = scores(:one)
  end

  test "visiting the index" do
    visit scores_url
    assert_selector "h1", text: "Scores"
  end

  test "creating a Score" do
    visit scores_url
    click_on "New Score"

    fill_in "Comentario", with: @score.comentario
    fill_in "Estado", with: @score.estado
    fill_in "Negativo", with: @score.negativo
    fill_in "Neutro", with: @score.neutro
    fill_in "Positivo", with: @score.positivo
    fill_in "Usuario Puntuado", with: @score.usuario_puntuado_id
    fill_in "Usuario Puntuador", with: @score.usuario_puntuador_id
    click_on "Create Score"

    assert_text "Score was successfully created"
    click_on "Back"
  end

  test "updating a Score" do
    visit scores_url
    click_on "Edit", match: :first

    fill_in "Comentario", with: @score.comentario
    fill_in "Estado", with: @score.estado
    fill_in "Negativo", with: @score.negativo
    fill_in "Neutro", with: @score.neutro
    fill_in "Positivo", with: @score.positivo
    fill_in "Usuario Puntuado", with: @score.usuario_puntuado_id
    fill_in "Usuario Puntuador", with: @score.usuario_puntuador_id
    click_on "Update Score"

    assert_text "Score was successfully updated"
    click_on "Back"
  end

  test "destroying a Score" do
    visit scores_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Score was successfully destroyed"
  end
end
