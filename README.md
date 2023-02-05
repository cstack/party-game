[![screenshot](./public/logo.png)](https://www.pitchparty.games/)

# How to Play

## 1. Fill in the blank
[![screenshot](./public/screenshot-1.png)](https://www.pitchparty.games/)

## 2. Get your neighbor's script, fill in the next blank
[![screenshot](./public/screenshot-2.png)](https://www.pitchparty.games/)

## 3. Enjoy the chaos
[![screenshot](./public/screenshot-3.png)](https://www.pitchparty.games/)

## 4. Vote for best
[![screenshot](./public/screenshot-4.png)](https://www.pitchparty.games/)

# Development
## Deploy
git push heroku main
heroku run rake db:migrate

## Smoke Test
heroku logs --tail
heroku open

## Debugging
heroku run rails console

## Monitoring
Game.last(10).each { |game| puts "#{game.token} - #{game.users.map(&:name).join(", ")}" };nil