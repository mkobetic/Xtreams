"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: testing
"
isAbstract
    "Override to true if a TestCase subclass is Abstract and should not have
     TestCase instances built from it"

    ^ self subclasses notEmpty
