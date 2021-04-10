require "rails_helper"

RSpec.feature "Play A Game", :type => :feature, js: true do
  before do
    Capybara.current_driver = :selenium_chrome_headless
  end

  def advance_time
    print "."
    # sleep 0.4
  end

  def wait_for_turbo_to_load
    sleep 0.5
  end

  def all_players_fill_in_an_answer(suffix, user1, user2)
    print "."
    expect(user1).to have_css('input#value')
    user1.fill_in "value", with: "P1#{suffix}"
    user1.click_on "Submit"

    # Capybara.using_session("player2") do
      expect(user2).to have_css('input#value')
      user2.fill_in "value", with: "P2#{suffix}"
      user2.click_on "Submit"
    # end
  end

  scenario "Play A Game" do
    user1 = Capybara::Session.new(:selenium_chrome_headless)
    user2 = Capybara::Session.new(:selenium_chrome_headless)

    user1.visit "#{page.server_url}/"
    wait_for_turbo_to_load

    user1.click_on "Edit Name"
    user1.fill_in "user_name", with: 'user1'
    user1.click_button "Update"
    expect(user1.find('.users')).to have_content('user1 (Edit Name)')

    user1.click_on "Create a Room"
    expect(user1).to have_content("Lobby")

    room_path = user1.current_path

    # Capybara.using_session("player2") do
      user2.visit "#{page.server_url}#{room_path}"
      wait_for_turbo_to_load
      user2.click_on "Join"
      user2.click_on "Edit Name"
      user2.fill_in "room_user_name", with: 'user2'
      user2.click_button "Save"
      expect(user2).to have_content("user1\nuser2 (Edit Name)")
    # end

    expect(user1).to have_content("user1 (Edit Name)\nuser2")

    user1.click_on "Start Game"
    # wait_for_turbo_to_load
    expect(user2).to have_css('input#value')
    user1.fill_in "value", with: "P1V1"
    user1.click_on "Submit"
    expect(user1).to have_content("Change Answer")
    user1.click_on "Change Answer"

    all_players_fill_in_an_answer("V1", user1, user2)
    all_players_fill_in_an_answer("V2", user1, user2)
    all_players_fill_in_an_answer("V3", user1, user2)
    all_players_fill_in_an_answer("V4", user1, user2)
    all_players_fill_in_an_answer("V5", user1, user2)
    all_players_fill_in_an_answer("V6", user1, user2)
    all_players_fill_in_an_answer("V7", user1, user2)
    all_players_fill_in_an_answer("V8", user1, user2)
    all_players_fill_in_an_answer("V9", user1, user2)
    all_players_fill_in_an_answer("V10", user1, user2)

    expect(user1).to have_css('input#value')
    expected_movie_text = "A(n) P1V1 movie starring P2V2 as a(n) P1V3 in P2V4 . "\
      "They meet a(n) P1V5 played by P2V6 . "\
      "The protagonist must P1V7 , but there is a problem: P2V8 . "\
      "To makes things even worse, P1V9 . "\
      "But by the end of the movie, P2V10 . "\
      "Now what should the movie be called?"
    if expected_movie_text != user1.find('.movie').text
      puts movie_text
    end
    expect(user1.find('.movie').text).to eq(expected_movie_text)
  
    all_players_fill_in_an_answer("Title", user1, user2)

    expect(user1).to have_css("input[value='VOTE!']")
    user1.select "P1Title", :from => "movie_id"
    user1.click_on "VOTE!"

    expect(user2).to have_css("input[value='VOTE!']")
    user2.select "P1Title", :from => "movie_id"
    user2.click_on "VOTE!"
    expect(user2).to have_content("Winner")

    expect(user1).to have_content("Winner")
    expect(user1).to have_content("P1Title")

    user1.click_on "New Game"

    expect(user1).to have_content("Start the game once everyone has joined")

    user1.select "Startup", :from => "template"
    user1.click_on "Start Game"

    expect(user1).to have_content("Pick a real-life tech company")
  end
end