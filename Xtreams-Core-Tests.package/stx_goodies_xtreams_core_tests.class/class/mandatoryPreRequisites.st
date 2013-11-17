"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: description
"
mandatoryPreRequisites
    "list all required mandatory packages.
     Packages are mandatory, if they contain superclasses of the package's classes
     or classes which are extended by this package.
     This list can be maintained manually or (better) generated and
     updated by scanning the superclass hierarchies
     (the browser has a menu function for that)
     However, often too much is found, and you may want to explicitely
     exclude individual packages in the #excludedFromPreRequisites method."

    ^ #(
        #'stx:goodies/sunit'    "TestAsserter - superclass of Xtreams::ReadingWritingTest "
        #'stx:libbasic'    "LibraryDefinition - superclass of stx_goodies_xtreams_core_tests "

        #'stx:goodies/xtreams/support'
        #'stx:goodies/xtreams/core'
        #'stx:goodies/xtreams/terminals'
        #'stx:goodies/xtreams/transforms'
        #'stx:goodies/xtreams/substreams'
    )

    "Modified: / 20-03-2013 / 19:56:45 / Jan Vrany <jan.vrany@fit.cvut.cz>"
