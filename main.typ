#let tsinswreng-heading-level = state("tsinswreng-heading-level", 0)

#let auto-heading(title, content, hargs: (:)) = context {
  tsinswreng-heading-level.update(n => n + 1)
  let current-lvl = tsinswreng-heading-level.get()
  [#heading(level: current-lvl + 1, ..hargs)[#title ]

  content

  tsinswreng-heading-level.update(n => n - 1)
}
