#import "template/cv.typ": *

#set_config(body: (theme: (line: green, accent: red), block_spacing: none))

#let contact = (
  name: "Jake Ryan",
  phone: "123-456-7890",
  email: "jake@su.edu",
  linkedin: "linkedin.com/in/jake",
  github: "github.com/jake",
  site: "example.com",
  location: "Brussels",
)

#show: resume
#header(name: contact.name)

#contacts[
  #contact_item(icons.location, contact.location)
  #contact_item(icons.phone, contact.phone)
  #contact_item(icons.email, contact.email, link: create_link(contact.email, email: true))
  #contact_item(icons.site, contact.site, link: create_link(contact.site))
  #contact_item(icons.linkedin, contact.linkedin, link: create_link(contact.linkedin))
  #contact_item(icons.github, contact.github, link: create_link(contact.github))
]

#resume_heading[Languages]
#lang_item()
#exp_item()
