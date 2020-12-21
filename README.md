# CACS Publications Page
A github page and script for generating and maintaining the publications page for CACS

## How to add a new publication to the page 
+ Add the document to the `papers/` folder
+ Fill out the publications details in the `publication_details.xml` file
+ Make a commit to master

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
			<link>http://cacs.usc.edu/papers/Tiwari-PhotoAmorphizationSb2Te3-JPCL20.pdf</link>			
		</publication>
		...
		...
	</<publications>
</root>
```

> Only one `root` and `publications` tab. However any number of `publications` tag be be present in the publication_details.xml file