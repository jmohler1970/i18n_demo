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

We also have a `.properties` which imports data in `ini` format. No one has asked for JSON, but that certainly could be done. All we are trying to do is get data into a struct that we can work with


# Back to coding



