"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: testing
"
isAbstract
    "Override to true if a TestCase subclass is Abstract and should not have
     TestCase instances built from it"

    ^ self subclasses notEmpty
