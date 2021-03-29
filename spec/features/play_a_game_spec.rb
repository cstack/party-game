require "rails_helper"

RSpec.feature "Play A Game", :type => :feature, js: true do
  before do
    Capybara.current_driver = :selenium_chrome_headless
  end

  scenario "Play A Game" do
    visit "/"
    sleep 0.2

    click_on "Edit Name"
    fill_in "user_name", with: 'user1'
    click_button "Update"
    sleep 0.2
    expect(find('.users').text).to eq('user1 (Edit Name)')

    click_on "Create a Room"
    sleep 0.2

    room_path = current_path

    Capybara.using_session("player2") do
      visit room_path
      click_on "Join"
      sleep 0.2
      click_on "Edit Name"
      fill_in "room_user_name", with: 'user2'
      click_button "Save"
      sleep 0.2
      expect(all('.users p').map(&:text)).to eq(["user1", "user2 (Edit Name)"])
    end

    expect(all('.users p').map(&:text)).to eq(["user1 (Edit Name)", "user2"])
  end
end