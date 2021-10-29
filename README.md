# `dorian-all`

Inlined version of tailwind CSS without CSS variables

e.g. for emails with premailer

Credits to https://tailwindcss.com

⚠️ A lot of things are broken, pull requests are welcome ❤️

### Install

```bash
gem install dorian-tailwind
```

Or as part of my other gems:

```bash
gem install dorian
```

### Usage

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
