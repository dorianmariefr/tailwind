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
  value = value.lines.grep_v(/^--/).join
  value = value.gsub(/var\([a-z0-9, #-]+\)/, "1")
  return if value.blank?
  ".#{clazz} { #{value} }"
end

slugs = []

LINKS.each do |link|
  slug = link.split("/").last
  doc = Nokogiri.HTML(get(link))
  trs = doc.css("tbody.align-baseline tr")

  content = trs.map { |tr| tr_to_css(tr) }.compact.join("\n\n")
  next if content.blank?
  slugs << slug
  File.write("#{ASSETS_PATH}/#{slug}.css", content)
end

File.write(
  "#{ASSETS_PATH}.css.scss",
  PREFLIGHT +
    slugs.map { |slug| "@import \"dorian-tailwind/#{slug}\";" }.join("\n")
)