# Deploy
git push heroku main
heroku run rake db:migrate

# Smoke Test
heroku logs --tail
heroku open

# Debugging
heroku run rails console

# Monitoring
Game.last(10).each { |game| puts "#{game.token} - #{game.users.map(&:name).join(", ")}" };nil