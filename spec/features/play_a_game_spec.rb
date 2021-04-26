require "rails_helper"

RSpec.feature "Play A Game", :type => :feature, js: true do
  def wait_for_turbo_to_load
    sleep 0.5
  end

  def all_players_fill_in_an_answer(turn_number, users)
    print "."
    users.each_with_index do |user, i|
      expect(user).to have_css("input#turn_#{turn_number}", visible: false)
      value = "P#{i+1}V#{turn_number}"
      user.fill_in "value", with: value
      user.click_on "Submit"
    end
  end

  scenario "Play A Game" do
    user1 = Capybara::Session.new(:selenium_chrome_headless)
    user2 = Capybara::Session.new(:selenium_chrome_headless)
    users = [user1, user2]

    user1.visit "#{page.server_url}/"
    wait_for_turbo_to_load

    user1.click_on "Edit Name"
    user1.fill_in "user_name", with: 'user1'
    user1.click_button "Update"
    expect(user1.find('.users')).to have_content('user1 (Edit Name)')

    user1.click_on "Create a Room"
    expect(user1).to have_content("Lobby")
    expect(user1.find('.url')).to have_content("https://www.pitchparty.games/rooms/#{Room.last.token}")
    expect(user1).to have_content("Start the game once everyone has joined")

    room_path = user1.current_path

    user2.visit "#{page.server_url}#{room_path}"
    wait_for_turbo_to_load
    user2.click_on "Join"
    expect(user2).to have_content("Waiting for leader to start the game")

    user2.click_on "Edit Name"
    user2.fill_in "room_user_name", with: 'user2'
    user2.click_button "Save"
    expect(user2).to have_content("user1\nuser2 (Edit Name)")
    expect(user1).to have_content("user1 (Edit Name)\nuser2")

    user1.click_on "Start Game"
    expect(user1).to have_content("🤔 user1\n🤔 user2\nOptions\nHome")
    expect(user2).to have_content("🤔 user1\n🤔 user2\nHome")
    expect(user2).to have_css('input#value')

    user1.fill_in "value", with: "P1V1"
    user1.click_on "Submit"
    expect(user1).to have_css("input[value='Change Answer']")
    expect(user1).to have_content("✅ user1\n🤔 user2\nOptions\nHome")
    expect(user2).to have_content("✅ user1\n🤔 user2\nHome")

    user1.click_on "Change Answer"
    expect(user1).to have_content("🤔 user1\n🤔 user2\nOptions\nHome")
    expect(user2).to have_content("🤔 user1\n🤔 user2\nHome")

    all_players_fill_in_an_answer("1", users)
    expect(user1).to have_content("🤔 user1\n🤔 user2\nOptions\nHome")
    expect(user2).to have_content("🤔 user1\n🤔 user2\nHome")

    user1.find('details.options').click
    user1.click_on "Restart Game"
    expect(user1).to have_content("Start the game once everyone has joined")
    expect(user2).to have_content("Waiting for leader to start the game")

    user1.select "Startup", :from => "template"
    user1.click_on "Start Game"
    all_players_fill_in_an_answer("1", users)
    all_players_fill_in_an_answer("2", users)
    all_players_fill_in_an_answer("3", users)
    all_players_fill_in_an_answer("4", users)
    all_players_fill_in_an_answer("5", users)
    all_players_fill_in_an_answer("6", users)

    expect(user1).to have_css("input#turn_7", visible: false)
    expected_story_text = "I’m working on a super stealth startup. It’s like P1V1 but for P2V2 . Have you ever had the problem where P1V3 ? Well, thanks to our P2V4 technology , you can just P1V5 instead. We'll make money by P2V6 . The startup is called ... ."
    if expected_story_text != user1.find('.story').text
      puts user1.find('.story').text
    end
    expect(user1.find('.story').text).to eq(expected_story_text)
  
    all_players_fill_in_an_answer("7", users)

    expect(user1).to have_css("input[value='VOTE!']")
    user1.select "P1V7", :from => "story_id"
    user1.click_on "VOTE!"

    expect(user2).to have_css("input[value='VOTE!']")
    user2.select "P1V7", :from => "story_id"
    user2.click_on "VOTE!"
    expect(user2).to have_content("Winner")

    expect(user1).to have_content("Winner")
    expect(user1).to have_content("P1V7")

    user1.click_on "New Game"

    expect(user1).to have_content("Start the game once everyone has joined")

    user1.select "Startup", :from => "template"
    user1.click_on "Start Game"

    expect(user1).to have_content("Pick a real-life tech company")
  end
end