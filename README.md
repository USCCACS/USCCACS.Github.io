# CACS Publications Page
A github page and script for generating and maintaining the publications page for CACS

## How to add a new publication to the page 
+ Congratulations on your recently accepted paper! If you are reading this then then you must be looking for how to update the cacs [publication page](https://usccacs.github.io/) to include your work
+ Begin the process of uploading the document in pdf format to the `papers/` directory of this repo. Visit the directory through this [link](https://usccacs.github.io/) and click on the the add files button on the top right to upload files. Files can be uploaded by selecting them from your folder or by drag and drop
+ After adding your files click on the commit changes button
+ Once the files are uploaded you must specify the exact words that will be used to diplay the publication on the [page](https://usccacs.github.io/)
+ Open the `publication_details.xml` [file](https://github.com/USCCACS/USCCACS.Github.io/blob/main/publication_details.xml) and edit the file from your browser
+ Modify the `publication` tag for adding the display text for each uploaded paper
+ The `title` tag is where you fill out the title of the work
+ The `author` tag is where you fill out all the author names
+ The `publisher` tag is where you fill out the name of the journal
+ The `rating` tag is where you fill out the pages or sequence in which your work has appeared
+ The `volume` is the issue number / volume in which your work has appeared
+ The `year`is where you fill out the year the work first appeared in publication
+ And now the `link`, pay close attention here since this is slightly tricky. Open the [papers directory](https://github.com/USCCACS/USCCACS.Github.io/tree/main/papers) in the repo and locate the most recent paper that you uploaded. Click on it to verify that the PDF can be viewed. Close to the branch name at the top you will find the file name as ` USCCACS.Github.io/papers/file-name.pdf `. Copy the filename starting from from `papers/...`. Pate this into the `link` tag (see the example below for clarity)
+ Click on commit changes and wait for the generator script to build the updated index page and go online.

## Schema of xml used 

```xml
<root>
	<publications>
		<publication>
			<title>Henry</title>
			<author>Ford</author>
			<publisher>Le Mans</publisher>
			<rating>8</rating>
			<volume>4</volume>
			<year>2020</year>
			<link>papers/Tiwari-PhotoAmorphizationSb2Te3-JPCL20.pdf</link>			
		</publication>
		...
		...
	</<publications>
</root>
```

> Only one `root` and `publications` tag. However any number of `publications` tag be be present in the publication_details.xml file
