#!/usr/bin/env ruby

require "nokogiri"
require "httparty"
require "active_support/all"
require "fileutils"

CACHE_PATH = "tmp/cache"
ASSETS_PATH = "app/assets/stylesheets/dorian-tailwind"
LINKS = File.read("docs-links.txt").split.grep_v(/container/)
PREFLIGHT = "@import \"dorian-tailwind/preflight\";\n"

FileUtils.mkdir_p(CACHE_PATH)
FileUtils.mkdir_p(ASSETS_PATH)

def get(url)
  filepath = "#{CACHE_PATH}/#{url.parameterize}.html"

  if File.exists?(filepath)
    File.read(filepath)
  else
    response = HTTParty.get(url)
    File.write(filepath, response.body)
    response.body
  end
end

def tr_to_css(tr)
  clazz, value = tr.css("td").map(&:text)
  clazz = clazz.gsub(".", "\\.").gsub("/", "\\/")
  value = value.lines.grep_v(/^--/).grep_v(/@/).grep_v(/animation/).join
  value.gsub!("var(--tw-backdrop-blur)", "blur(0)")
  value.gsub!("var(--tw-backdrop-brightness)", "brightness(1)")
  value.gsub!("var(--tw-backdrop-contrast)", "contrast(1)")
  value.gsub!("var(--tw-backdrop-grayscale)", "grascale(0)")
  value.gsub!("var(--tw-backdrop-hue-rotate)", "hue-rotate(0deg)")
  value.gsub!("var(--tw-backdrop-invert)", "invert(0)")
  value.gsub!("var(--tw-backdrop-opacity)", "1")
  value.gsub!("var(--tw-backdrop-saturate)", "saturate(1)")
  value.gsub!("var(--tw-backdrop-sepia)", "sepia(0)")
  value.gsub!("var(--tw-bg-opacity)", "1")
  value.gsub!("var(--tw-blur)", "blur(0)")
  value.gsub!("var(--tw-border-opacity)", "1")
  value.gsub!("var(--tw-brightness)", "brightness(1)")
  value.gsub!("var(--tw-contrast)", "contrast(1)")
  value.gsub!("var(--tw-divide-opacity)", "1")
  value.gsub!("var(--tw-divide-x-reverse)", "0")
  value.gsub!("var(--tw-divide-y-reverse)", "0")
  value.gsub!("var(--tw-drop-shadow)", "drop-shadow(0 0 #0000)")
  value.gsub!("var(--tw-gradient-stops)", "#f9fafb, rgba(249, 250, 251, 0)")
  value.gsub!("var(--tw-grayscale)", "grayscale(0)")
  value.gsub!("var(--tw-hue-rotate)", "hue-rotate(0deg)")
  value.gsub!("var(--tw-invert)", "invert(0)")
  value.gsub!("var(--tw-placeholder-opacity)", "1")
  value.gsub!("var(--tw-ring-color)", "rgba(59, 130, 246, 0.5)")
  value.gsub!("var(--tw-ring-inset)", "")
  value.gsub!("var(--tw-ring-offset-color)", "#fff")
  value.gsub!("var(--tw-ring-offset-shadow)", "0 0 #0000")
  value.gsub!("var(--tw-ring-offset-width)", "0")
  value.gsub!("var(--tw-ring-shadow)", "0 0 #0000")
  value.gsub!("var(--tw-rotate)", "0")
  value.gsub!("var(--tw-saturate)", "saturate(1)")
  value.gsub!("var(--tw-scale-x)", "0")
  value.gsub!("var(--tw-scale-y)", "0")
  value.gsub!("var(--tw-sepia)", "sepia(0)")
  value.gsub!("var(--tw-shadow)", "0 0 #0000")
  value.gsub!("var(--tw-skew-x)", "0")
  value.gsub!("var(--tw-skew-y)", "0")
  value.gsub!("var(--tw-space-x-reverse)", "0")
  value.gsub!("var(--tw-space-y-reverse)", "0")
  value.gsub!("var(--tw-text-opacity)", "1")
  value.gsub!("var(--tw-translate-x)", "0")
  value.gsub!("var(--tw-translate-y)", "0")
  value.gsub!("var(--tw-ring-offset-shadow, 0 0 #0000)", "0 0 #0000")
  value.gsub!("var(--tw-ring-shadow, 0 0 #0000)", "0 0 #0000")

  return if value.blank?
  ".#{clazz} { #{value} }"
end

slugs = []

puts "Unsupported (yet):"
puts "- container"

LINKS.each do |link|
  slug = link.split("/").last
  doc = Nokogiri.HTML(get(link))
  trs = doc.css("tbody.align-baseline tr")

  content = trs.map { |tr| tr_to_css(tr) }.compact.join("\n\n")
  if content.present?
    slugs << slug
    File.write("#{ASSETS_PATH}/#{slug}.css", content)
  else
    puts "- #{slug}"
  end
end

File.write(
  "#{ASSETS_PATH}.css.scss",
  PREFLIGHT +
    slugs.map { |slug| "@import \"dorian-tailwind/#{slug}\";" }.join("\n")
)
