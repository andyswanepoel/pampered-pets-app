require "application_system_test_case"

class PetsTest < ApplicationSystemTestCase
  setup do
    @pet = pets(:one)
  end

  test "visiting the index" do
    visit pets_url
    assert_selector "h1", text: "Pets"
  end

  test "should create pet" do
    visit pets_url
    click_on "New pet"

    fill_in "Age", with: @pet.age
    fill_in "Name", with: @pet.name
    fill_in "Pettable", with: @pet.pettable_id
    fill_in "Pettable type", with: @pet.pettable_type
    fill_in "Sex", with: @pet.sex
    click_on "Create Pet"

    assert_text "Pet was successfully created"
    click_on "Back"
  end

  test "should update Pet" do
    visit pet_url(@pet)
    click_on "Edit this pet", match: :first

    fill_in "Age", with: @pet.age
    fill_in "Name", with: @pet.name
    fill_in "Pettable", with: @pet.pettable_id
    fill_in "Pettable type", with: @pet.pettable_type
    fill_in "Sex", with: @pet.sex
    click_on "Update Pet"

    assert_text "Pet was successfully updated"
    click_on "Back"
  end

  test "should destroy Pet" do
    visit pet_url(@pet)
    click_on "Destroy this pet", match: :first

    assert_text "Pet was successfully destroyed"
  end
end
