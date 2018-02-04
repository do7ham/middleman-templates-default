require 'uglifier'

# -------------------------------------
#  Site-specific Config
# -------------------------------------

# Aria Current
activate :aria_current

# Sprockets
require 'sassc'
activate :sprockets do |c|
  c.expose_middleman_helpers = true
end

# RailsAssets
if defined? RailsAssets
  RailsAssets.load_paths.each do |path|
    sprockets.append_path path
  end
end

# -------------------------------------
#  Layout-specific Configuration
# -------------------------------------

# No Layout
page '/*.xml',    layout: false
page '/*.txt',    layout: false
page '/*.json',   layout: false
page '/404.html', layout: false

# Haml
Haml::TempleEngine.disable_option_validator!
Haml::Options.defaults[:format] = :html5

# Sass
config[:sass] = { line_comments: false, debug_info: false }

# -------------------------------------
#   Helpers
# -------------------------------------

helpers do
  # If you need helpers for use in this file, then you
  # can define them here. Otherwise, they should be defined
  # in `helpers/custom_helpers.rb`.
end

# -------------------------------------
#  Server Enviroment
# -------------------------------------

configure :server do
  # Host
  config[:host] = ENV['DEVELOPMENT_URL']
  # Relative URLs
  activate :relative_assets
  config[:relative_links] = true
end

# -------------------------------------
#  Development-specific Configuration
# -------------------------------------

configure :development do
  # Assets Pipeline Sets
  config[:css_dir]    = 'assets/stylesheets'
  config[:js_dir]     = 'assets/javascripts'
  config[:images_dir] = 'assets/images'
  config[:fonts_dir]  = 'assets/fonts'
  # Image Tag Helper
  activate :automatic_image_sizes
  # Pretty URLs
  activate :directory_indexes
  page '/404.html', directory_index: false
  # Autoprefixer
  activate :autoprefixer do |prefix|
    prefix.browsers = ['last 2 versions']
    prefix.cascade  = false
    prefix.inline   = true
  end
  # Livereload
  activate :livereload do |reload|
    reload.no_swf = true
  end
end

# -------------------------------------
#  Production-specific Configuration
# -------------------------------------

configure :production do
  # Host
  config[:host] = ENV['PRODUCTION_URL']
  # Assets Pipeline Sets
  config[:css_dir]    = 'assets/stylesheets'
  config[:js_dir]     = 'assets/javascripts'
  config[:images_dir] = 'assets/images'
  config[:fonts_dir]  = 'assets/fonts'
  # Image Tag Helper
  activate :automatic_image_sizes
  # Pretty URLs
  activate :directory_indexes
  page '/404.html', directory_index: false
  # Autoprefixer
  activate :autoprefixer do |prefix|
    prefix.browsers = ['last 2 versions']
    prefix.cascade  = false
    prefix.inline   = true
  end
  # Clean Build
  require_relative './lib/clean_build'
  activate :clean_build
end

# -------------------------------------
#  Build-specific Configuration
# -------------------------------------

configure :build do
  # Asset Hash
  activate :asset_hash
  # Minify CSS on Build
  activate :minify_css, inline: true
  # Minify HTML on Build
  activate :minify_html do |html|
    html.remove_input_attributes = false
    html.remove_intertag_spaces  = false
  end
  # Minify JS on Build
  activate :minify_javascript, inline: true,
    compressor: proc {
      ::Uglifier.new(mangle: false, output: {comments: :none}, compress: {unsafe: true})
    }
  # Relative URLs
  activate :relative_assets
  config[:relative_links] = true
end
