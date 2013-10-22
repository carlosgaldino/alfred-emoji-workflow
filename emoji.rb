require './emoji_symbols'

def item_xml(options = {})
  <<-ITEM
  <item arg="#{options[:arg]}" uid="#{options[:uid]}">
    <title>#{options[:title]}</title>
    <icon>#{options[:path]}</icon>
  </item>
  ITEM
end

images_path = File.expand_path('../images/emoji', __FILE__)

names = Dir["#{images_path}/*.png"].sort.map { |fn| File.basename(fn, '.png') }

query = Regexp.escape(ARGV.first).delete(':')

items = names.grep(/#{query}/i).map do |elem|
  path = File.join(images_path, "#{elem}.png")
  emoji_code = ":#{elem}:"

  emoji_arg = ARGV.size > 1 ? EMOJI_SYMBOLS.fetch(elem.to_sym, emoji_code) : emoji_code

  item_xml({ :arg => emoji_arg, :uid => elem, :path => path, :title => emoji_code })
end.join

output = "<?xml version='1.0'?>\n<items>\n#{items}</items>"

puts output
