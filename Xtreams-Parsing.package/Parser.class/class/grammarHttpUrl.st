"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: grammars
"
grammarHttpUrl
^'/* This is an example grammar for toying with */
Http			<-	HTTP User? Host Port? Components? Query? !.
User		<-	Username (COLON Password)? AT
Port			<-	COLON [0-9]+
Components	<-	(SLASH Component)* SLASH?

Host 		<- Ident (DOT Host)?
Ident 		<- IdentStart IdentCont*
IdentStart 	<- [a-zA-Z]
IdentCont 	<- IdentStart / [_0-9] / "-"
Query 		<- QUESTION KeyValue (AMP KeyValue)*
KeyValue 	<- Key EQUAL Value?
Key			<- Ident
Value		<- Ident
Username	<- Ident
Password	<- IdentCont+
Component	<- Ident (DOT Component)?
AMP 		<- "&"
AT			<- "@"
COLON		<- ":"
DOT 		<- "."
EQUAL 		<- "="
HTTP		<- "http://"
QUESTION 	<- "?"
SLASH		<- "/"
'