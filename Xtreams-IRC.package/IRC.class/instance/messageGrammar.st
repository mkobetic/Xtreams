"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private - receiving
"
messageGrammar
^'
message	<-	prefix? (command / reply) param* trailing? newline
prefix		<-	":" .{1, space}
command	<-	[a-zA-Z]+
reply		<-	[0-9]{3}
param		<-	space !":" [^\s\n\r]+
trailing		<-	space ":" [^\n\r]+
space		<-	[\s]
newline		<-	[\n\r]
'