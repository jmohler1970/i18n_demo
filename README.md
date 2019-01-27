# i18n_demo
Internationalization Demo


# Getting started

- If Commandbox, is not installed. Go over and install it. It will take care of ColdFusion including updates https://www.ortussolutions.com/products/commandbox

- Start Commandbox by typing `box`

- Install i18n by typeing `install`

- Here is the tough part. Start ColdFusion by typing `start` . This may take a while if Commandbox needs to download ColdFusion

- If all goes well, the `index.cfm` page will open up in your browser. You don't even have to look for it.

- If all this worked, type `stop`. We need to get some language file.

# Language

 My favorite place to get language files is GetSimpleCMS's language file download. You can find that at http://get-simple.info/extend/

At the time of this writing, they had a bunch of languages but the "View All" button was not working. You can do a search and find whatever language you want.

## Wait a second, these are PHP files

Yes, these are .php files. And we are going to read them. We are not going to actually run php, but we are going parse though them like text files and extract the information that we want.

Let's step back for a second. If you work in an organization that is large enough to translate website, they will have a team, or at least an individual dedicated to that task. This person is likely to be an expert in the language they are translating, they are UNLIKELY to to be a programmer. It is reasonable to expect that they can handle a text file in a specific format. They are not going to be doing complicated programming gymnastics. It is going to be very simple from the programming point of view.

## But why PHP?

GetSimpleCMS has lots of language file and they are kind of generic for websites. This gives us something to work with and to learn from.


## I still don't like this.

We also have a `.properties` which imports data in `.ini` format. No one has asked for JSON, but that certainly could be done. All we are trying to do is get data into a struct that we can work with

## Why not store these in a DB?

There are a couple of reasons which may or may not be applicable in your environment.

1. It is easy to do file version control in version control systems
2. Tracking the state of data in a database is non trivial
3. Even if you have the database tables, you have to make an entire GUI to manage changes
4. When you commit a file it is easy to commit whole files (as in a new language), parts of files, or single lines. Databases are only good at single line updates.
5. If I want to start a new language, say Canadian English, I can copy and paste `en_US.php` or `en_GB.php` in one quick shot. With a database, I am once again creating tool to manage this.

There may be other reasons too.

# `cgi.http_accept_language`

`cgi.http_accept_language` is a variable that needs attention today. It is a comma separated list of all the languages that you have identified that you want. Languages in general are language dash country. Just because a language is spoken one way in one country, does not mean it isn't different some where else. This also gets into how numbers, date, and currency are formatted.

Your web browser has list of the languages that it would like a response to be. There is no requirement that a page or a web service actually returns a particular language. Let's look where this is set. In Chrome, if you go to 
- settings
- advanced settings
- languages

You should have something in there. I am adding a few variation of Spanish. If we go back to the web page, we can see that it changed.

## Now that we have this string

Now that we have this string, what do we do with it. On lines 45 to 57, I am going to see if I have a language that the browser wants. If not I am going to return an error message. There are other approaches. Maybe you code will just return a designated language. Perhaps Esperanto written in the Greek alphabet would be a better solution.



# Code Review.

Let's get into the main part of the code review.


## Lang file

Let's take a look at one of the language files. I am goint to look at Italian as my example. If you want this to work on your computer, you will have to download language files for Get Simple (http://get-simple.info/extend/). Let's take a look at line 13.

To load up this file, I am going to go through all the rows. If I see a `=>`, I am going to treat the item before it as the key, and the item after it as the value. I need to message the quotes and comments. but it is not too bad. The code does not relie on any PHP engine.


## `i18n.cfc`

Let's go over to `i18n/i18n.cfc`. Line 23: Let's make sure there is a cache region.

What is a ColdFusion cache? One of the cool things about ColdFusion is that it is really easy to cache data in a `<cfquery>`. You just add a time frame and off you go. ColdFusion's cache does that for any kind of variable. Better yet, you can save it for as long as the server is running. Better yet, you can group them.

On line 33 we are doing the magic: `CachePut(languageKey, i18n[languageKey], 1, 1, variables.cache.language);`

If you look at Adobe's documention, this function call breaks down like this:

> id = languageKey,
> Value = i18n,
> timeSpan = 1,
> idleTime = 1,
> region = variables.cache.language

So how do you read this? It is a little hard to read because `region` is way at the end and it is actually our starting point. I have created a cache region just for i18n. It is going to have an id of language key. You can kind of think of id as a struct key were region is a struct. Except you can't access data like a struct.

Moving on to value. I don't like how Adobe describes this. They say value is "The value of the object. Can be any data type supported by ColdFusion". When you are hearing value, don't think of simple values. String and numbers don't get saved here. If you string is 100KB long, you can save it. Object is not a good word either. When I hear "object", I think `.cfc`s.

I just wish Adobe would have said "Structs, or Arrays, or any data type". Most commonly variables that take up lot of space and/or take a while to calculate.

My language files take a while to process and can get quite large. They are good candidate for cacheing.


Line 41: We do some basic transformation to figure out which language we should be using. We can base this on `cgi.HTTP_ACCEPT_LANGUAGE`.

`cgi.HTTP_ACCEPT_LANGUAGE` is this formatted string that you browser sends over indicating which language it wants you to respond with. **Comma**'s separate the language. **Semicolon** indicate how much you like that language. If no value is given, then it assumed to be a top language. My `cgi.HTTP_ACCEPT_LANGUAGE` indicates that I primarily want `en-US` but I will settle for `en`.

Disclaimer 1: I have to give a disclaimer here, I did not build out all the combinations.

Disclaimer 2: All of this is different from character encoding

Disclaimer 3: Just because I browser says it want a language, does not mean you have to return that language. This field can be completely ignored

Disclaimer 4: `cgi.HTTP_ACCEPT_LANGUAGE` can have hostile data in it. I am a bit concerned that on line 48, `canonicalize()` may not be enough.

Back to the code, The goal is for line 79 to return back the results

If we can't figure out what to do, on line 84 we return the original key.


## Reading a properties file

Some quick thoughts on readProperties, Line 88.

This reads files with and `.ini` format. It is really quick and clean. Originally I was going to build my presentation off of this. But my language skills are not that good. That is one of reasons I switched to the PHP approach. You can see that it takes a bit of work to get PHP to work. The PHP approach isn't any slower. All the is cached anyway.

If you are starting out with language files, I would recommend the `.ini` approach.


# See it in action

I can pick out prefered language. This includes some options that are differen from my browser

I can verify that one of my keys works. If I blank it out, I have some comon options

I have some debug below to show how much the cache is getting used.


# Resources

- http://get-simple.info/extend/
- https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-functions/functions-c-d/CachePut.html

- Yet another way to do this: https://stackoverflow.com/questions/54357098/how-to-use-org-apache-commons-configuration-with-coldfusion