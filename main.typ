#let tsinswreng-heading-level = state("tsinswreng-heading-level", 0)

#let auto-heading(title, content, hargs: (:), labl: none) = context {
  tsinswreng-heading-level.update(n => n + 1)
  let current-lvl = tsinswreng-heading-level.get()
  [#heading(level: current-lvl + 1, ..hargs)[#title ]
    #if labl != none { label(labl) }]

  content

  tsinswreng-heading-level.update(n => n - 1)
}
