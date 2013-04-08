"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
testHeading

	| input output |
	input :=
'	= Hello _World_ =
Good _Bye_ *[World>http://www.google.com]*

[Short-Link]
* Bullet1 < Bullet2
* Bullet2
# Numbered
## Nested
---
	preformatted	text
---
{{{
	code
}}}
and again
	|| Heading1	|| Heading2
	|| Data 1		|| Data2
	|| Data 3		|| Data4
After table'.
	output := parser parse: 'Page' stream: input reading actor: PEG.WikiGenerator new.
	self assert: output printString =
 '<div>
	<h1>
		Hello 
		<span style="font-style: italic">World</span>
	</h1>
	<p>
		Good 
		<span style="font-style: italic">Bye</span>
		 
		<span style="font-weight: bold">
			<a href="http://www.google.com">World</a>
		</span>
	</p>
	
	<p>
		<a href="Short-Link.html">Short-Link</a>
	</p>
	<ul>
		<li> Bullet1 &lt; Bullet2</li>
		<li> Bullet2</li>
	</ul>
	<ol>
		<li> Numbered</li>
		<li>
			<ol>
				<li> Nested</li>
			</ol>
		</li>
	</ol>
	<pre>	preformatted	text
</pre>
	<pre>	code
</pre>
	<p>and again</p>
	<table>
		<tableHead>
			<tr>
				<th> Heading1	</th>
				<th> Heading2</th>
			</tr>
		</tableHead>
		<tableBody>
			<tr>
				<td> Data 1		</td>
				<td> Data2</td>
			</tr>
			<tr>
				<td> Data 3		</td>
				<td> Data4</td>
			</tr>
		</tableBody>
	</table>
	<p>After table</p>
</div>'