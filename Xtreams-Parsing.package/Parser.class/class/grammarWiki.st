"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: grammars
"
grammarWiki
	"This syntax is variation of google wiki syntax (http://code.google.com/p/support/wiki/WikiSyntax). It is used to mark up the package comments so that they can be turned into web pages. It is important that the mark-up isn't visually obtrusive so that the comments are still comfortably readable.
	The three major players in wiki syntax are:
		http://code.google.com/p/support/wiki/WikiSyntax
		http://en.wikipedia.org/wiki/Help:Wiki_markup
		http://c2.com/cgi/wiki?TextFormattingRules
	"
	^
'Page <- (Preformatted / Code / UnorderedList / OrderedList / Heading / Table / Paragraph / Empty)*

LineCharacter <- [^\n]
Flow <- Escape / Bold / Italic / LinkShort / LinkFull / LineCharacter
Escape <- "**" / "__" / "[["
Bold <- "*" Flow{"*"}
Italic <- "_" Flow{"_"}
LinkShort <- "[" .{&[>\]]} "]"
LinkFull <- "[" Flow{">"} .{"]"}

Line <- Flow{1,"\n"}
Paragraph <- Line
Empty <- "\n"
Preformatted <- "---\n" .{"---\n"} 
Code <- "{{{\n" .{"}}}\n"} 
Whitespace <- [\t\s]*
Heading		<-	Heading4 / Heading3 / Heading2 / Heading1
Heading1	<-	Whitespace "= " Flow{" =\n"}
Heading2	<-	Whitespace "== " Flow{" ==\n"}
Heading3	<-	Whitespace "=== " Flow{" ===\n"}
Heading4	<-	Whitespace "==== " Flow{" ====\n"}

Bullet1 <-	Whitespace "*" Line
Bullet2 <-	Whitespace "**" Line
Bullet3 <-	Whitespace "***" Line
UnorderedList <- (UnorderedList2 / Bullet1)+
UnorderedList2 <- (UnorderedList3 / Bullet2)+
UnorderedList3 <- Bullet3+

Hash1 <- Whitespace "#" Line
Hash2 <- Whitespace "##" Line
Hash3 <- Whitespace "###" Line
OrderedList <- (OrderedList2 / Hash1)+
OrderedList2 <- (OrderedList3 / Hash2)+
OrderedList3 <- Hash3+

Table <-	HeadingRow TableRow*
HeadingRow <-	Whitespace "||" HeadingCell{"\n"}
HeadingCell	<-	Flow{"||"}
TableRow <-	Whitespace "||" Cell{"\n"}
Cell	<-	Flow{"||"}
'