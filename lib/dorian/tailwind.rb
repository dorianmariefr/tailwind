module Dorian
  class Tailwind
    class Engine < ::Rails::Engine
      initializer "dorian-tailwind.assets.precompile" do |app|
        app.config.assets.precompile << "dorian-tailwind.css.scss"
      end
    end
  end
end
