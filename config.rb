# allow a custom build dir to be passed in via env var
build_dir = ENV['MIDDLEMAN_BUILD_DIR'] || "build"
set :build_dir, build_dir

# build target configuration
activate :target

# add bower path to sprockets
activate :bower

# Indent html for pretty debugging and do not sort attributes
set :slim, pretty: true

# group all assets under single dir and allow that to be passed in via env var.
# (not sure of use case for env var yet, but it seems interesting.)
assets_dir = ENV['MIDDLEMAN_ASSETS_DIR'] || "assets"
set :css_dir,    "#{assets_dir}/css"
set :js_dir,     "#{assets_dir}/js"
set :images_dir, "#{assets_dir}/img"
