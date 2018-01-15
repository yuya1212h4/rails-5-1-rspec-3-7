require 'rails_helper'

feature "About BigCo modal" do
  # aboutのモーダル表示を切り替える
  scenario "toggles display of the modal about display", js: true do
    visit root_path
    # page.save_screenshot "test1.png"
    expect(page).not_to have_content 'About BigCo'
    expect(page).not_to have_content 'BigCo produces the finest widgets in all the land.'

    click_link 'About Us'

    expect(page).to have_content 'About BigCo'
    expect(page).to have_content 'BigCo produces the finest widgets in all the land.'
    # page.save_screenshot "test2.png"

    within '#about_us' do
      click_button 'Close'
    end

    # page.save_screenshot "test3.png"
    expect(page).not_to have_content 'About BigCo'
    expect(page).not_to have_content 'BigCo produces the finest widgets in all the land.'
  end
end