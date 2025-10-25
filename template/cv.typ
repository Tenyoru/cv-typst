//TODO add toml config
#let theme = (text: rgb("#111111"), line: red, accent: blue)
#let block_spacing = (above: 0.7em, below: 1em)
#let default_retraits = 10

#let edit_date() = {
  place(
    top + right,
    block[
      #set text(size: 5pt, font: "DejaVu Sans Mono", fill: gray)
      \This document was last updated on #datetime.today().display("[year]-[month]-[day]") using #underline(link("https://typst.app/home")[*Typst*])
    ],
  )
}

#let resume(body) = {
  set list(indent: 1em)
  show list: set text(size: 0.92em)
  // show link: underline
  // show link: set underline(offset: 3pt)

  set page(paper: "us-letter", margin: (x: 0.5in, y: 0.5in), numbering: (page, pages) => {
    set text(fill: gray)
    str(page) + " / " + str(pages)
  })

  set text(size: 11pt)
  edit_date()
  body
}

#let name_header(name) = {
  set text(size: 2.25em, fill: theme.accent)
  [*#name*]
}

#let insert_image(name) = {
  box(baseline: 0.20em, image("../images/" + name + ".svg", format: "svg"), height: 1em)
}

#let header(name: "Jake Ryan", phone: "", email: "", linkedin: "", github: "", site: "") = {
  align(center, [
    #v(10pt)
    #name_header(name)
    #v(-5pt)

    #if phone != "" [
      #insert_image("phone") #phone
    ]
    #if email != "" [
      #insert_image("email") #link("mailto:" + email)[#email]
    ]
    #if site != "" [
      #insert_image("site") #link("https://" + site)[#site]
    ]
    #if linkedin != "" [
      #insert_image("linkedin") #link("https://" + linkedin)[#linkedin]
    ]
    #if github != "" [
      #insert_image("github") #link("https://" + github)[#github]
    ]
  ])
  v(-3pt)
}

#let resume_content(content) = {
  set block(above: block_spacing.above, below: block_spacing.below)
  content
}

#let resume_heading(txt) = {
  show heading: set text(size: 0.92em, weight: "regular", fill: theme.accent)
  //smallcaps()
  block[
    #v(4pt)
    = #txt
    #v(-3pt)
    #line(length: 100%, stroke: 0.5pt + theme.line)
    #v(-1pt)
  ]
}

#let section(name, content) = {
  resume_heading(name)
  resume_content(content)
}

#let edu_item(name: "Sample University", degree: "B.S in Bullshit", location: "Foo, BA", date: "Aug. 1600 - May 1750") = {
  set block(above: block_spacing.above, below: block_spacing.below)
  pad(left: 1em, right: 0.5em, grid(columns: (3fr, 1fr), align(left)[
    *#name* \
    _#degree _
  ], align(right)[
    #location \
    _#date _
  ]))
}

#let exp_item(name: "Sample Workplace", role: "Worker", date: "June 1837 - May 1845", location: "Foo, BA", ..points) = {
  set block(above: block_spacing.above, below: block_spacing.below)
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
  set block(above: block_spacing.above, below: block_spacing.below)
  pad(left: 1em, right: 0.5em, box[
    *#name* | _#skills _ #h(1fr) #date
    #list(..points)
  ])
}

#let skill_item(category: "Skills", skills: "Balling, Yoga") = {
  set block(above: block_spacing.above)
  set text(size: 0.91em)
  pad(left: 1em, right: 0.5em, block[*#category*: #skills])
}

#let lang_item(lang: "English", level: "Native") = {
  set block(above: block_spacing.above)
  // set text(size: 0.91em)
  block[ - *#lang*: #level ]
}
