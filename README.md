This repository is an attempt to use git to maintain multiple parallel ports of Xtreams across multiple smalltalk dialects. All ports follow the structure laid out by the [Cypress](https://github.com/CampSmalltalk/Cypress) project. The goal is to come up with an arrangement that will help move changes between the ports easily. Whether that will mean some clever scheme alowing to merge things across or whether it will be some form of commit cherry-picking remains to be seen.

All the available ports are treated as equal and therefore none of them is the master. Instead each port has its own branch:

| Branch | Dialect      | Cypress implementation   | Development Repository    
|--------|:------------:|:------------------------:|:-----------------------------------
| vw     | VisualWorks  | [CampSmalltalk/STIG]     | [Cincom Public Store Repository][1]
| pharo  | Pharo/Squeak | [CampSmalltalk/filetree] | [Squeaksource][2]
| stx    | Smalltalk/X  | [Cypress][4]             | [CVUT][3]

[1]: http://www.cinomsmalltalk.com/publicRepository
[2]: http://squeaksource.com/Xtreams.html
[3]: https://swing.fit.cvut.cz/hg/stx.goodies.xtreams
[4]: https://bitbucket.org/janvrany/stx-goodies-cypress

There may be some use for the master branch eventually as we figure things out, but currently it will be kept empty.

### TODO:

  * [ ] get all the ports to use the same file naming convention so that the corresponding things match at the file level
  * [ ] clean up any discrepancies in terms of formatting, attribute naming/handling etc.
  * [ ] figure out the best way to move code