#let tsinswreng-heading-level = state("tsinswreng-heading-level", 0)
#let tsinswreng-heading-label-stack = state(
  "tsinswreng-heading-label-stack",
  (),
)

#let auto-heading(
  title,
  content,
  hargs: (:),
  labl: none,
  labl_nest: false,
  labl_constr: it => it.join(":"),
  labl_from_title: it => lower(it),
) = context {
  let labl = if labl == auto {
    assert(
      type(title) == str,
      message: "When using auto label title must be string",
    )
    labl_from_title(title)
  } else {
    labl
  }
  tsinswreng-heading-level.update(n => n + 1)
  if labl != none and labl_nest {
    tsinswreng-heading-label-stack.update(s => (..s, labl))
  }
  let current-lvl = tsinswreng-heading-level.get()
  let current-labl = (..tsinswreng-heading-label-stack.get(), labl)
  [#heading(level: current-lvl + 1, ..hargs)[#title ]
    #if labl != none {
      label(labl_constr(current-labl))
    }]

  content

  tsinswreng-heading-level.update(n => n - 1)
  if labl != none and labl_nest {
    tsinswreng-heading-label-stack.update(s => {
      let _ = s.pop()
      s
    })
  }
}
