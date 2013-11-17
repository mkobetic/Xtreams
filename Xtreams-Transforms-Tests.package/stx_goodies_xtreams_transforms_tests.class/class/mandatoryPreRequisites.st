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
        #'stx:goodies/sunit'    "TestCase - superclass of Xtreams::InterpretingStreamTest "
        #'stx:goodies/xtreams/core/tests'    "Xtreams::FiniteReadingWritingTests - superclass of extended Xtreams::CollectionReadingWritingTest "
        #'stx:goodies/xtreams/terminals/tests'    "Xtreams::CollectionReadingWritingTest - extended "
        #'stx:libbasic'    "LibraryDefinition - superclass of stx_goodies_xtreams_transforms_tests "
    )
