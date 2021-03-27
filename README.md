# Deploy
git push heroku main
heroku run rake db:migrate

# Smoke Test
heroku logs --tail
heroku open