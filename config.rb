require "bundler/setup"
Bundler.require

###
# Compass
###

# Susy grids in Compass
# First: gem install susy --pre
# require 'susy'

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


# Activate sync extension
activate :sync do |sync|
  sync.fog_provider = 'AWS' # Your storage provider
  sync.fog_directory = 'redhat-open-gov' # Your bucket name
  sync.fog_region = 'ap-southeast-2'
  sync.aws_access_key_id = 'AKIAIZFBTADLWW6C5X7Q'
  sync.aws_secret_access_key = 'FV6xsSbNcS1713ZDc9YpiiCsbdl6V/tCzDCTWGHb'
  sync.existing_remote_files = 'delete' # What to do with your existing remote files? ( keep or delete )
  # sync.gzip_compression = false # Automatically replace files with their equivalent gzip compressed version
  # sync.after_build = false # Disable sync to run after Middleman build ( defaults to true )
end

###
# Helpers
###

helpers do
  def menu_link(name, link)
    unless page_classes[/(\S+\s+){#{1}}/].blank?
      klass = (link == page_classes[/(\S+\s+){#{1}}/].strip ? 'active' : nil)
    end
    link_to name, "/#{link}", class: klass
  end
end

activate :directory_indexes

set :css_dir,     "assets/stylesheets"
set :js_dir,      "assets/javascripts"
set :images_dir,  "assets/images"

after_configuration do
  sprockets.append_path "assets/bower_components" 
end

# Build-specific configuration
configure :build do

  activate :minify_css
  activate :minify_javascript

  # Enable cache buster
  # activate :cache_buster

  # Use relative URLs
  activate :relative_assets

  # Compress PNGs after build
  # First: gem install middleman-smusher
  # require "middleman-smusher"
  # activate :smusher

  # Or use a different image path
  # set :http_path, "/Content/images/"
end
