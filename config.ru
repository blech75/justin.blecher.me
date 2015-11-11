# from middleman-heroku
# https://github.com/middleman/middleman-heroku/blob/master/config.ru
#
# with the following additions/changes:
#  * added HTTP basic auth block
#  * abstracted out some values
#
# ----

# Modified version of TryStatic, from rack-contrib
# https://github.com/rack/rack-contrib/blob/master/lib/rack/contrib/try_static.rb

# Serve static files under a `build` directory:
# - `/` will try to serve your `build/index.html` file
# - `/foo` will try to serve `build/foo` or `build/foo.html` in that order
# - missing files will try to serve build/404.html or a tiny default 404 page

NOT_FOUND_PATH = '404.html'
NOT_FOUND_TITLE = 'Error: Page not found'
DOCROOT = 'build'
HTTP_AUTH_AREA_NAME = "Restricted Area"


module Rack
  class TryStatic
    def initialize(app, options)
      @app = app
      @try = ['', *options.delete(:try)]
      @static = ::Rack::Static.new(lambda { [404, {}, []] }, options)
    end

    def call(env)
      orig_path = env['PATH_INFO']
      found = nil

      @try.each do |path|
        resp = @static.call(env.merge!({'PATH_INFO' => orig_path + path}))
        break if 404 != resp[0] && found = resp
      end

      found or @app.call(env.merge!('PATH_INFO' => orig_path))
    end
  end
end

use Rack::Deflater

## add HTTP auth for heroku apps. config'd via heroku environment variables
if !ENV['HTTP_USER'].nil? && !ENV['HTTP_PASSWORD'].nil?
  use Rack::Auth::Basic, HTTP_AUTH_AREA_NAME do |username, password|
    [username, password] == [ENV['HTTP_USER'], ENV['HTTP_PASSWORD']]
  end
end

use Rack::TryStatic,
  root: DOCROOT,
  urls: %w(/),
  try: %w(.html index.html /index.html),
  cache_control: 'public, max-age=2592000'

# Run your own Rack app here or use this one to serve 404 messages:
run lambda { |env|
  not_found_page = File.expand_path('../' + DOCROOT + '/' + NOT_FOUND_PATH, __FILE__)
  content = File.exist?(not_found_page) ? File.read(not_found_page) : NOT_FOUND_TITLE
  return [404, { 'Content-Type'  => 'text/html'}, [content]]
}
