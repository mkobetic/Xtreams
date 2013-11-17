"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: description - project information
"
productInstallDirBaseName
    "Returns a default installDir which will appear in <app>.nsi.
     This is usually not the one you want to keep"

    ^ (self package asCollectionOfSubstringsSeparatedByAny:':/') last
