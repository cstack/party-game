require "rails_helper"

RSpec.feature "Play A Game", :type => :feature, js: true do
  before do
    Capybara.current_driver = :selenium_chrome_headless
  end

  def advance_time
    print "."
    sleep 0.2
  end

  def all_players_fill_in_an_answer(suffix)
    fill_in "value", with: "P1#{suffix}"
    click_on "Submit"

    Capybara.using_session("player2") do
      fill_in "value", with: "P2#{suffix}"
      click_on "Submit"
    end
    advance_time
  end

  def movie_text
    find('.movie').text
  end

  scenario "Play A Game" do
    visit "/"
    advance_time

    click_on "Edit Name"
    fill_in "user_name", with: 'user1'
    click_button "Update"
    advance_time
    expect(find('.users').text).to eq('user1 (Edit Name)')

    click_on "Create a Room"
    advance_time

    room_path = current_path

    Capybara.using_session("player2") do
      visit room_path
      click_on "Join"
      advance_time
      click_on "Edit Name"
      fill_in "room_user_name", with: 'user2'
      click_button "Save"
      advance_time
      expect(all('.users p').map(&:text)).to eq(["user1", "user2 (Edit Name)"])
    end

    expect(all('.users p').map(&:text)).to eq(["user1 (Edit Name)", "user2"])

    click_on "Start Game"
    fill_in "value", with: "P1V1"
    click_on "Submit"

    all_players_fill_in_an_answer("V1")
    all_players_fill_in_an_answer("V2")
    all_players_fill_in_an_answer("V3")
    all_players_fill_in_an_answer("V4")
    all_players_fill_in_an_answer("V5")
    all_players_fill_in_an_answer("V6")
    all_players_fill_in_an_answer("V7")
    all_players_fill_in_an_answer("V8")
    all_players_fill_in_an_answer("V9")
    all_players_fill_in_an_answer("V10")

    expected_movie_text = "A(n) P1V1 movie starring P2V2 as a(n) P1V3 in P2V4 . "\
      "They meet a(n) P1V5 played by P2V6 . "\
      "The protagonist must P1V7 , but there is a problem: P2V8 . "\
      "To makes things even worse, P1V9 . "\
      "But by the end of the movie, P2V10 . "\
      "Now what should the movie be called?"
    if expected_movie_text != movie_text
      puts movie_text
    end
    expect(movie_text).to eq(expected_movie_text)
  
    all_players_fill_in_an_answer("Title")

    select "P1Title", :from => "movie_id"
    click_on "VOTE!"
    Capybara.using_session("player2") do
      select "P1Title", :from => "movie_id"
      click_on "VOTE!"
    end
    advance_time

    expect(page).to have_content("P1Title")

    click_on "New Game"
    advance_time

    expect(page).to have_content("Pick a movie genre")
  end
end