# tsinswreng-auto-heading

A Typst package that provides automatic heading level management.

## Overview

`tsinswreng-auto-heading` provides a simple way to create nested headings without manually tracking heading levels. The `auto-heading` function automatically increments and decrements the heading level as you enter and exit sections.

## Usage

```typst
#import "@preview/tsinswreng-auto-heading:0.1.0": auto-heading

#let H = auto-heading

#H("Chapter 1")[
  This is the content of chapter 1.
  
  #H("Section 1.1")[
    This is section 1.1 content.
    
    #H("Subsection 1.1.1")[
      This is a subsection.
    ]
  ]
  
  #H("Section 1.2")[
    This is section 1.2.
  ]
]
```

## How It Works

The `auto-heading(title, content)` function uses two shared states:
- A **level counter** — incremented on entry, decremented on exit.
- A **label stack** — when `labl_nest` is on, each heading's label is pushed on entry and popped on exit, so the current label always reflects the full path of parent labels down to this heading.

So on each call it:
1. Pushes the new level (and label, if `labl_nest`) onto the stack
2. Creates a heading at the appropriate level with the derived label
3. Renders the content
4. Pops the level (and label) back off the stack when done

This lets you nest sections naturally without worrying about absolute heading levels, and lets nested labels automatically include their ancestors.

## Heading arguments (`hargs`)

Pass extra keyword arguments through to Typst's built-in `heading()` function. The `level` is always computed automatically.

```typst
#auto-heading(
  "Chapter 1",
  [Content],
  hargs: (numbering: "1.", bookmarked: true),
)
```

## Labels

Attach a Typst `label` to each heading. Use `labl` with a string, or `auto` to derive it from the title. With `labl: auto`, the `labl_from_title` function converts the title into the label (lowercased by default).

```typst
#let H = auto-heading

#H("Introduction", labl: "intro")[Text]
// -> heading labeled <intro>

#H("Introduction", labl: auto)[Text]
// -> heading labeled <introduction>

#H("Introduction", labl: auto, labl_from_title: it => upper(it))[Text]
// -> heading labeled <INTRODUCTION>
```

### Nested labels

With `labl_nest: true`, parent labels are tracked so the generated label reflects the full hierarchy. Use `labl_constr` to control the separator.

```typst
#let H = auto-heading
#H("Chapter 1", labl: "c1", labl_nest: true)[
  #H("Section 1.1", labl: "s1", labl_nest: true)[Text]
]
// -> inner label: <c1:s1>

#H("Chapter 1", labl: "c1", labl_nest: true, labl_constr: it => it.join("."))[
  #H("Section 1.1", labl: "s1", labl_nest: true)[Text]
]
// -> inner label: <c1.s1>
```

## License

MIT License