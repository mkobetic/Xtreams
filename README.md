This repository is an attempt to use git to maintain multiple parallel ports of Xtreams across multiple smalltalk dialects. All ports follow the structure laid out by the Cypress project. The goal is to come up with an arrangement that will help move changes between the ports easily. Whether that will mean some clever scheme alowing to merge things across or whether it will be some form of commit cherry-picking remains to be seen.

All the available ports are treated as equal and therefore none of them is the master. Instead each port has its own branch:

|| branch || dialect || Cypress implementation || development repository
|| vw || VisualWorks || STIG || Cincom Public Store Repository
|| pharo ||  Pharo/Squeak || Filetree || SqueakMap
|| stx || Smalltalk/X || Cypress || CVUT 

There may be some use for the master branch eventually as we figure things out, but currently it will be kept empty.

TODO:

  * [ ] get all the ports to use the same file naming convention so that the corresponding things match at the file level
  * [ ] clean up any discrepancies in terms of formatting, attribute naming/handling etc.
  * [ ] figure out the best way to move code