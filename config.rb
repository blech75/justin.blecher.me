# allow a custom build dir to be passed in via env var
build_dir = ENV['MIDDLEMAN_BUILD_DIR'] || "build"
set :build_dir, build_dir

# build target configuration
activate :target

# Indent html for pretty debugging and do not sort attributes
set :slim, pretty: true

# group all assets under single dir and allow that to be passed in via env var.
# (not sure of use case for env var yet, but it seems interesting.)
assets_dir = ENV['MIDDLEMAN_ASSETS_DIR'] || "assets"
set :css_dir,    "#{assets_dir}/css"
set :js_dir,     "#{assets_dir}/js"
set :images_dir, "#{assets_dir}/img"
set :fonts_dir,  "#{assets_dir}/fonts"



# use .bowerrc to define location for bower assets and tell sprockets about it
# from middleman-bower-template: https://github.com/headcanon/middleman-bower-template/blob/master/config.rb#L47
#
# Add bower's directory to sprockets asset path
after_configuration do
  @bower_config = JSON.parse(IO.read("#{root}/.bowerrc"))
  sprockets.append_path File.join "#{root}", @bower_config["directory"]
end


# from default middleman config (minus the asset dir stuff, already set above)
# https://github.com/middleman/middleman/blob/v3-stable/middleman-core/lib/middleman-core/templates/shared/config.tt
# ----

###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
#  :which_fake_page => "Rendering a fake page with a local variable" }

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
# configure :development do
#   activate :livereload
# end

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end


# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  activate :asset_hash

  # Use relative URLs
  activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end
