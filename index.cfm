<!---
The MIT License (MIT)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
--->


<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>i18n Demo</title>

	<link rel="stylesheet" href="https://unpkg.com/buefy/dist/buefy.min.css">
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" crossorigin="anonymous">

	<script src="https://unpkg.com/vue@2.5.17"></script>
	<script src="https://unpkg.com/buefy@0.6.7"></script>
	<script src="https://unpkg.com/axios@0.18.0/dist/axios.min.js"></script>

</head>
<body>

<cfscript>
	totalSize = 0;

	param form.lang = cgi.HTTP_ACCEPT_LANGUAGE;
	param form.key = "EMAIL_ERROR";

	variables.i18n = new i18n.i18n();
	variables.i18n.setupApplication();

	arLang = variables.i18n.getLang();
</cfscript>

	<section class="hero is-info">
		<div class="hero-body">
			<div class="container">
				<h1 class="title">
					ColdFusion reader of PHP i18n language files
				</h1>
				<h2 class="subtitle">
					By James Mohler
				</h2>
			</div>
		</div>
	</section>


<section class="section">
	<div class="container">

<form action="?" method="post">

	<cfoutput>

		<label class="label">Language</label>
		<div class="select">
			<select name="lang">
				<option value="#cgi.HTTP_ACCEPT_LANGUAGE#" <cfif cgi.HTTP_ACCEPT_LANGUAGE EQ form.lang>selected</cfif>>Browser default (#cgi.HTTP_ACCEPT_LANGUAGE#)</option>
				<cfloop array="#arLang#" item="item">
					<option value="#item#" <cfif item EQ form.lang>selected</cfif>>#item#</option> 
				</cfloop>
			</select>
		</div>

		<div class="field">
			<div class="control">
				<label class="label">Key</label>
				<input type="text" class="input" name="key" list="keys" value="#EncodeForHTMLAttribute(form.key)#" />

				<datalist id="keys">
					<option value="WEBSITENAME_ERROR">
					<option value="EMAIL_ERROR">
					<option value="DELETE_FILE">
					<option value="SITEMAP_CREATED">
					<option value="OR_GREATER_REQ">
				</datalist>
			</div>
		</div>
	</cfoutput>

	<div class="field">
		<div class="control">
			<button type="submit" class="button is-primary">Submit</button>
		</div>
	</div>

</form>

<p>&nbsp;</p>

<div class="notification is-info is-size-4">
	<cfoutput>#variables.i18n.geti18n(form.key, [], form.lang)#</cfoutput>
</div>


<h1 class="is-size-2">Cache Status</h1>


<table class="table is-striped">
<thead>
<tr>
	<th>Cacheid</th>
	<th style="text-align : center;">Created Time</th>
	<th style="text-align : center;">Last Updated</th>
	<th style="text-align : center;">Last Hit</th>
	<th style="text-align : right;">Hit Count</th>
	<th style="text-align : right;">Hit Count %</th>
	<th style="text-align : right;">Size (KB)</th>
</tr>
</thead>

<cfoutput>
	<cfloop index="metadata" array="#variables.i18n.getCacheIDs()#">

		<cfset totalSize += metadata.size>
			
		<tr>
			<td><code>#metadata.lang#</code></td>
			<td style="text-align : center;">#LSTimeFormat(metadata.createdTime, "h:mm:ss")#</td>
			<td style="text-align : center;">#LSTimeFormat(metadata.lastupdated, "h:mm:ss")#</td>
			<td style="text-align : center;">#LSTimeFormat(metadata.lastHit, "h:mm:ss")#</td>
			<td style="text-align : right;">#metadata.hitcount#</td>
			<td style="text-align : right;">
				<cfif metadata.cache_hitcount GT 0>
					<cfset percent_of_hits = 100.0 * metadata.hitcount / metadata.cache_hitcount>
					#LSNumberFormat(percent_of_hits, '999.9')# %
				</cfif>
			</td>
			<td style="text-align : right;">#LSNumberFormat(metadata.size \ 1024)#</td>
		</tr>
	</cfloop>
</cfoutput>
<tfoot>
	<tr>
		<th></th>
		<th></th>
		<th></th>
		<th></th>
		<th></th>
		<th></th>
		<th style="text-align : right;"><cfoutput>#LSNumberFormat(totalSize \ 1024)#</cfoutput></th>
	</tr>	
</tfoot>	
</table>


	</div>
</section>


</body>
</html>