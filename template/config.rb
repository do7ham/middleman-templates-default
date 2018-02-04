
activate :autoprefixer do |prefix|
  prefix.browsers = 'last 2 versions'
end

# No Layout
page '/*.xml',  layout: false
page '/*.txt',  layout: false
page '/*.json', layout: false
