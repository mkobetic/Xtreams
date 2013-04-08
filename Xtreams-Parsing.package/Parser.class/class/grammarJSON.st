"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: grammars
"
grammarJSON
^'object		<-	"{" associations? "}"
associations	<-	association ("," association)*
association	<-	string ":" value
array		<-	"[" values? "]"
values		<-	value ("," value)*
value		<-	string / number / object / array / true / false / null
true			<-	"true"
false		<-	"false"
null			<-	"null"
string		<-	["] character{["]}
character	<-	"\\" ["\\/bfnrt]
			/	"\\u" [0-9A-Fa-f]{4}
number		<-	"-"? [0-9]+ ("." [0-9]+)? ([eE] [+-]? [0-9]+)?
'