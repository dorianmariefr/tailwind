Gem::Specification.new do |s|
  s.name = "dorian-tailwind"
  s.version = "0.3.0"
  s.summary = "Inlined version of tailwind CSS without CSS variables"
  s.description = s.summary + "\n\n" + "e.g. for emails with premailer"
  s.authors = ["Dorian Marié"]
  s.email = "dorian@dorianmarie.fr"
  s.files = Dir["{app,lib}/**/*"]
  s.homepage = "https://github.com/dorianmariefr/tailwind"
  s.license = "MIT"
  s.add_dependency "rails"
end
