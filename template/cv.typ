//TODO add toml config
#let resume_config = state("resume_config", (theme: (line: red, accent: blue), block_spacing: (above: 0.7em, below: 1em)))
#let icons = (
  phone: "phone.svg",
  email: "email.svg",
  site: "site.svg",
  linkedin: "linkedin.svg",
  github: "github.svg",
  location: "location.svg",
)

#let set_config(body: (theme: none, block_spacing: none)) = {
  resume_config.update(old => (
    theme: if body.theme != none { body.theme } else { old.theme },
    block_spacing: if body.block_spacing != none { body.block_spacing } else { old.block_spacing },
  ))
}

#let edit_date() = {
  let date = datetime.today().display("[month repr:long] [year]")
  place(top + right, dy: -10pt, block[
    #set text(style: "italic", size: 7pt, font: "DejaVu Sans Mono", fill: gray)
    \Last updated in #(lower(date))
  ])
}

#let resume(body) = {
  set list(indent: 1em)
  show list: set text(size: 0.92em)
  // show link: underline
  // show link: set underline(offset: 3pt)

  set page(paper: "us-letter", margin: (x: 0.5in, y: 0.5in), numbering: (page, pages) => {
    set text(fill: gray, style: "italic")
    str(page) + " / " + str(pages)
  })
  edit_date()

  set text(size: 11pt)
  body
}

#let center_alignment(body) = {
  align(center, body)
}

#let contacts(body) = {
  center_alignment(body)
  // v(-3pt)
}

#let name_header(name) = {
  context {
    let cfg = resume_config.get()
    set text(size: 2.25em, fill: cfg.theme.accent)
    [*#name*]
  }
}

#let contact_item(image, content, link: none, image_baseline: 0.15em, image_height: 0.8em) = {
  box(baseline: 0.20em, std.image("../images/" + image), height: 1em)
  h(0.2em)
  if link != none {
    std.link(link)[#content]
  } else {
    content
  }
  h(0.5em)
}

#let create_link(link, email: false) = {
  if email == true {
    return "mailto:" + link
  }
  return "https://" + link
}

#let header(name: "Jake Ryan", phone: "", email: "", linkedin: "", github: "", site: "", location: "") = {
  center_alignment[
    #v(7pt)
    #name_header(name)
    #v(-10pt)
  ]
}

#let resume_content(content) = {
  set block(above: block_spacing.above, below: block_spacing.below)
  content
}

#let resume_heading(txt) = {
  context {
    let cfg = resume_config.get()
    show heading: set text(size: 0.92em, weight: "regular", fill: cfg.theme.accent)
    //smallcaps()
    block[
      #v(4pt)
      = #txt
      #v(-3pt)
      #line(length: 100%, stroke: 0.5pt + cfg.theme.line)
      #v(-1pt)
    ]
  }
}

#let section(name, content) = {
  resume_heading(name)
  resume_content(content)
}

#let item_block() = {
  context {
    let cfg = resume_config.get()
    set block(above: cfg.block_spacing.above, below: cfg.block_spacing.below)
  }
}

#let edu_item(name: "Sample University", degree: "B.S in Bullshit", location: "Foo, BA", date: "Aug. 1600 - May 1750") = {
  item_block()
  pad(left: 1em, right: 0.5em, grid(columns: (3fr, 1fr), align(left)[
    *#name* \
    _#degree _
  ], align(right)[
    #location \
    _#date _
  ]))
}

#let exp_item(name: "Sample Workplace", role: "Worker", date: "June 1837 - May 1845", location: "Foo, BA", ..points) = {
  item_block()
  pad(left: 1em, right: 0.5em, box[
    #grid(columns: (3fr, 1fr), align(left)[
      *#role* \
      _#name _
    ], align(right)[
      #date \
      _#location _
    ])
    #list(..points)
  ])
}

#let project_item(name: "Example Project", skills: "Programming Language 1, Database3", date: "May 1234 - June 4321", ..points) = {
  item_block()
  pad(left: 1em, right: 0.5em, box[
    *#name* | _#skills _ #h(1fr) #date
    #list(..points)
  ])
}

#let skill_item(category: "Skills", skills: "Balling, Yoga") = {
  item_block()
  set text(size: 0.91em)
  pad(left: 1em, right: 0.5em, block[*#category*: #skills])
}

#let lang_item(lang: "English", level: "Native") = {
  item_block()
  pad(left: 1em, right: 0.5em, block[ *#lang*: #level ])
}
