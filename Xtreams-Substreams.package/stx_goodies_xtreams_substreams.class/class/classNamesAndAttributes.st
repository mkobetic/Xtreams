"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: description - contents
"
classNamesAndAttributes
    "lists the classes which are to be included in the project.
     Each entry in the list may be: a single class-name (symbol),
     or an array-literal consisting of class name and attributes.
     Attributes are: #autoload or #<os> where os is one of win32, unix,..."

    ^ #(
	"<className> or (<className> attributes...) in load order"
	#'Xtreams::ReadSubstream'
	#'Xtreams::StitchReadStream'
	#'Xtreams::StitchWriteStream'
	#'Xtreams::WriteSubstream'
	#'stx_goodies_xtreams_substreams'
	#'Xtreams::MatchReadSubstream'
	#'Xtreams::MatchWriteSubstream'
	#'Xtreams::PositionReadSubstream'
	#'Xtreams::PositionWriteSubstream'
	#'Xtreams::TestReadSubstream'
	#'Xtreams::TestWriteSubstream'
	#'Xtreams::LimitReadSubstream'
	#'Xtreams::LimitWriteSubstream'
    )
