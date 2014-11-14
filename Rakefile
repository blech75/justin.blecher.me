# from middleman-heroku
# https://github.com/middleman/middleman-heroku/blob/master/Rakefile
#
# with the following additions/changes:
#  * pass MIDDLEMAN_BUILD_TARGET env var to middleman
# ----

# use the ruby buildpack's assets:precompile task as a way to build (precompile)
# the static pages (our "assets")
namespace :assets do
  task :precompile do
    # FIXME: avoid hardcoding MIDDLEMAN_BUILD_TARGET here. look for existing
    # env var and pass that instead, if it exists. i'd like to make this useful
    # everywhere, not just heroku.
    sh "MIDDLEMAN_BUILD_TARGET=heroku middleman build"
  end
end
