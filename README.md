On https://tailwindcss.com/docs

```js
console.log(
  [...document.querySelectorAll("a")].map(({ href }) => href).join("\n")
)
```

```
cat links.txt | grep "tailwindcss.com/docs/" | each "puts l.split('#').first" | sort | uniq > docs-links.txt
```
