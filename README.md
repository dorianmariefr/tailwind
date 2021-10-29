# `dorian-all`

Inlined version of tailwind CSS without CSS variables

e.g. for emails with premailer

Credits to https://tailwindcss.com

⚠️ A lot of things are broken, pull requests are welcome ❤️

### Install

```
gem "dorian-tailwind"
```

### Usage

in your `email.css.scss` for instance:

```
//= require dorian-tailwind
```

### How it was built

On https://tailwindcss.com/docs

```js
console.log(
  [...document.querySelectorAll("a")].map(({ href }) => href).join("\n")
)
```

```
cat links.txt | grep "tailwindcss.com/docs/" | each "puts l.split('#').first" | sort | uniq > docs-links.txt
```

Then `bundle && ./scrapper && prettier --write .`

### Unsupported (yet):

Auto-generated. Mostly because of CSS variables, and random docs pages, and because I don't use them, again, pull requests welcome ❤️

- container
- adding-base-styles
- adding-new-utilities
- backdrop-blur
- backdrop-brightness
- backdrop-contrast
- backdrop-grayscale
- backdrop-hue-rotate
- backdrop-invert
- backdrop-opacity
- backdrop-saturate
- backdrop-sepia
- background-opacity
- blur
- border-opacity
- breakpoints
- brightness
- browser-support
- configuration
- configuring-variants
- contrast
- customizing-colors
- customizing-spacing
- dark-mode
- divide-opacity
- drop-shadow
- editor-support
- extracting-components
- functions-and-directives
- gradient-color-stops
- grayscale
- hover-focus-and-other-states
- hue-rotate
- installation
- invert
- just-in-time-mode
- optimizing-for-production
- placeholder-opacity
- plugins
- preflight
- presets
- responsive-design
- ring-color
- ring-opacity
- rotate
- saturate
- scale
- sepia
- skew
- text-opacity
- theme
- translate
- upgrading-to-v2
- using-with-preprocessors
- utility-first
