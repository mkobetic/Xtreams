grammars
grammarXML
^'/* Documents */
document			<-	prolog element Misc*

/* Characters */
Char				<-	[\x000001-\x00D7FF \x00E000-\x00FFFD \x010000-\x10FFFF]
RestrictedChar		<-	[\x000001-\x000008 \x00000B-\x00000C \x00000E-\x00001F \x00007F-\x000084 \x000086-\x00009F]

/* Common Syntactic Constructs */
S					<-	[\s\t\r\n]+
NameStartChar		<-	[: A-Z _ a-z \x0000C0-\x0000D6 \x0000D8-\x0000F6 \x0000F8-\x0002FF \x000370-\x00037D \x00037F-\x001FFF
						\x00200C-\x00200D \x002070-\x00218F \x002C00-\x002FEF \x003001-\x00D7FF \x00F900-\x00FDCF
						\x00FDF0-\x00FFFD /* The following range is beyond javascripts character set: \x010000-\x0EFFFF */]
NameChar			<-	NameStartChar / [\- . 0-9 \x0000B7 \x000300-\x00036F \x00203F-\x002040]
Name				<-	NameStartChar NameChar*
Names				<-	Name ("\s" Name)*
Nmtoken			<-	NameChar+
Nmtokens			<-	Nmtoken ("\s" Nmtoken)*
EntityValue			<-	["] ([^%&"] / PEReference / Reference)* ["]
					/	[''] ([^%&''] / PEReference / Reference)* ['']
AttValue				<-	["] ([^<&"] / Reference)* ["]
					/	[''] ([^<&''] / Reference)* ['']
SystemLiteral		<-	(["] [^"]* ["]) / ([''] [^'']* [''])
PubidLiteral			<-	["] PubidChar{["]} / [''] PubidChar{['']} ['']
PubidChar			<-	[\s \n \r a-zA-Z0-9 \-''()+,./:=?;!*#@$_%]

/* Character Data and Markup */
CharData			<-	[^<&]{"]]>"}

/* Comments */
Comment			<-	"<!--" Char{"-->"} "-->"

/* Processing Instructions */
PI					<-	"<?" PITarget (S Char{"?>"})? "?>"
PITarget				<-	!([Xx] [Mm] [Ll]) Name

/* CData Sections */
CDSect				<-	CDStart CData CDEnd
CDStart				<-	"<![CDATA["
CData				<-	Char{CDEnd}
CDEnd				<-	"]]>"

/* Prolog and Document Type Declaration */
prolog				<-	XMLDecl Misc* (doctypedecl Misc*)?
XMLDecl			<-	"<?xml" VersionInfo EncodingDecl? SDDecl? S? "?>"
VersionInfo			<-	S "version" Eq ([''] VersionNum [''] / ["] VersionNum ["])
Eq					<-	S? "=" S?
VersionNum			<-	"1.0" / "1.1"
Misc				<-	Comment / PI / S
doctypedecl			<-	"<!DOCTYPE" S Name (S ExternalID)? S? ("[" intSubset "]" S?)? ">"
DeclSep				<-	PEReference / S
intSubset			<-	(markupdecl / DeclSep)*
markupdecl			<-	elementdecl / AttlistDecl / EntityDecl / NotationDecl / PI / Comment
extSubset			<-	TextDecl? extSubsetDecl
extSubsetDecl		<-	(markupdecl / conditionalSect / DeclSep)*

/* Standard Document Declaration */
SDDecl				<-	S "standalone" Eq (([''] ("yes" / "no") ['']) / (["] ("yes" / "no") ["]))

/* Logical Structures */
element				<-	EmptyElemTag
					/	STag content ETag

/* Start-Tags, End-Tags, Empty-Element Tags */
STag				<-	"<" Name (S Attribute)* S? ">"
Attribute				<-	Name Eq AttValue
ETag				<-	"</" Name S? ">"
content				<-	CharData? ((element / Reference / CDSect / PI / Comment / ElementError) CharData?)*
EmptyElemTag		<-	"<" Name (S Attribute)* S? "/>"
ElementError		<-	!"</" "<"

/* Element Type Declaration */
elementdecl			<-	"<!ELEMENT" S Name contentspec S? ">"
contentspec			<-	"EMPTY" / "ANY" / Mixed / children

/* Element Content */
children				<-	(choice / seq) [?*+]?
cp					<-	(Name / choice / seq) [?*+]?
choice				<-	"(" S? cp (S? "|" S? cp)+ S? ")"
seq					<-	"(" S? cp (S? "," S? cp)* S? ")"
Mixed				<-	"(" S? "#PCDATA" (S? "|" S? Name)* S? ")*"
					/	"(" S? "#PCDATA" S? ")"

/* Attribute-List Declaration */
AttlistDecl			<-	"<!ATTLIST" S Name AttDef* S? ">"
AttDef				<-	S Name AttType S DefaultDecl
AttType				<-	StringType / TokenizedType / EnumeratedType
StringType			<-	"CDATA"
TokenizedType		<-	"IDREFS" / "IDREF" / "ID" / "ENTITY" / "ENTITIES" / "NMTOKENS" / "NMTOKEN"
EnumeratedType		<-	NotationType / Enumeration
NotationType		<-	"NOTATION" S "(" S? Name (S? "|" Name)* S? ")"
Enumeration			<-	"(" S? Nmtoken (S? "|" S? Nmtoken)* S? ")"
DefaultDecl			<-	"#REQUIRED" / "#IMPLIED" / ("#FIXED" S)? AttValue

/* Conditional Sections */
conditionalSect		<-	includeSect / ignoreSect
includeSect			<-	"<![" S? "INCLUDE" S? "[" extSubsetDecl "]]>"
ignoreSect			<-	"<![" S? "IGNORE" S? "[" ignoreSectContents* "]]>"
ignoreSectContents	<-	Ignore ("<![" ignoreSectContents "]]>" Ignore)*
Ignore				<-	Char{"<![" / "]]>"}

/* Character and Entity References */
CharRef				<-	"&#" [0-9]+ ";"
					/	"&#x" [0-9 a-f A-F]+ ";"
Reference			<-	EntityRef / CharRef / ReferenceError
EntityRef			<-	"&" Name ";"
PEReference		<-	"%" Name ";"
ReferenceError		<-	"&"

/* Entity Declarations */
EntityDecl			<-	GEDecl / PEDecl
GEDecl				<-	"<!ENTITY" S Name S EntityDef S? ">"
PEDecl				<-	"<!ENTITY" S "%" S Name S PEDef S? ">"
EntityDef			<-	EntityValue / (ExternalID NDataDecl?)
PEDef				<-	EntityValue / ExternalID
ExternalID			<-	"SYSTEM" S SystemLiteral
					/	"PUBLIC" S PubidLiteral S SystemLiteral
NDataDecl			<-	S "NDATA" S Name

/* Parsed Entities */
TextDecl			<-	"<?xml" VersionInfo? EncodingDecl S? "?>"
extParsedEnt		<-	(TextDecl? content)
EncodingDecl		<-	S "encoding" Eq (["] EncName ["] / [''] EncName [''])
EncName			<-	[A-Z a-z] [A-Z a-z 0-9 . _ \-]*

/* Notation Declarations */
NotationDecl			<-	"<!NOTATION" S Name S (ExternalID / PublicID) S? ">"
PublicID				<-	"PUBLIC" S PubidLiteral
'