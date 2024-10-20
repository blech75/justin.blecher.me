# If you have OpenSSL installed, we recommend updating
# the following line to use "https"
#source 'http://rubygems.org'
source "https://rubygems.org"

# heroku wants the ruby version set here in the Gemfile, too.
# ensure this remains in sync with .ruby-version
ruby '3.2.5'

# nice ruby gem for pre-commit hooks
# http://jish.github.io/pre-commit/
gem "pre-commit"

# middleman, our friendly neighborhood static site generator
# http://middlemanapp.com
gem "middleman", "~> 4.2"

# sprockets is no longer inclded in core
gem "middleman-sprockets"

# helpful for debugging middleman
# https://github.com/AndrewKvalheim/middleman-pry
gem "middleman-pry", group: :development


# redcarpet is nicer than kramdown
# https://github.com/vmg/redcarpet
gem "redcarpet"

# better than HAML
# http://slim-lang.com
gem 'slim', '4.1' # s v5 doesn't work w/ middleman



### DEPLOYMENT

# for running the app on heroku
# https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server
gem "puma"

# foreman manges the running of the app on heroku via the Procfile
# http://ddollar.github.io/foreman/
gem "foreman"
