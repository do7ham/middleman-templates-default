# *************************************
#  AssetHelpers
# *************************************
require 'middleman-sprockets'
require 'middleman-core'
require 'sprockets'

module AssetHelpers
  # Minify Inline CSS
  # ==================================
  def minify_inline_css css_string
    rLineBreaks = /\n/
    rCSSComments = /\/\*[^*]*\*+(?:[^*\/][^*]*\*+)*\//
    rExtraSpaces = / +/
    rOpenBrackets = / \{ /
    rColons = /: /
    rSemiColons = /; /
    css_string.to_s.gsub(rCSSComments,'').gsub(rLineBreaks,'').gsub(rExtraSpaces,' ').gsub(rOpenBrackets, '{').gsub(rColons, ':').gsub(rSemiColons, ';')
  end
  # Stylesheet Inline Tag
  # ==================================
  def stylesheet_inline_tag(*names, **options)
    names.map { |name|
      name += ".css" unless name.include?(".css")
      css_path = sitemap.resources.select do |p|
        p.source_file && p.source_file.include?(name)
      end.first
      outputCSS = minify_inline_css(css_path.render)
      "<style>#{outputCSS}</style>"
    }.reduce(:+)
  end
  # Javascript Inline Tag
  # ==================================
  def javascript_inline_tag(*names, **options)
    names.map { |name|
      name += '.js' unless name.include?('.js')
      js_path = sprockets.find_asset(name).to_s
      "<script type='text/javascript'>#{js_path}</script>"
    }.reduce(:+)
  end
end
