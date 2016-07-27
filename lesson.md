---
## **Module 1A. What are Digital Object Identifiers and Why Do They Matter ?**
---

Digital Object Identifiers (DOIs) are unique names assigned to research outputs (as well as other resources) that are represented in some way on the Internet. DOIs are established an international information standard as ISO 26324:2012   The DOI distinguishes the information resource from others (including other versions of the same intellectual work!). The DOI also provides a persistent web link to a representation of that information on the Internet. DOIs are actionable: when put in URL form (http://dx.doi.org/{DOI}, the DOI automatically redirects the user to a landing page that offers information about the resource and often a link to the resource itself.  

The DOI is NOT by itself an indicator of open access content or a seal of quality. Yet information resources that are assigned DOIs tend to be of enduring value; are likely to be used and cited by others; and are maintained by a publisher or other information provider who is committed to curating and preserving the resource over time. Examples of research-related information resources assigned DOIs include journal articles, curated datasets, theses, conference papers, and books.

A DOI is considered a persistent identifier because it reliably resolves to a human- and machine-readable landing page for the information resource. The DOI system is designed with the technical, bsiness, and human infrastructure required to ensure that the DOI will always point to relevant content on the Web. Whether or not a user can click through the landing page to fetch the full content depends on various circumstances unrelated to the DOI system: format of the resource, restrictions and conditions governing access; authentication requirements; software compatibility; etc. 

The metadata associated with the DOI is often rich enough to provide useful data for a researcher. This lesson and the next look at the array of useful public data associated with DOIs.


  


**Exercise 1A(1). Demonstrate that a DOI redirects to the web landing page for an associated information resource.**`$curl http://dx.doi.org/10.1103/PhysRev.109.193`

`$ curl -s -S http://dx.doi.org/10.7935/K5H41PBP`

_Whose websites did the redirects for each DOI take you to?_**Exercise 1A(2) Resolve a DOI to confirm its validity, and determine the title of the associated information resource.**`$curl -L -S -S http://dx.doi.org/10.1103/PhysRevLett.116.061102 >redirect1.txt`

`$grep "<title>" redirect1.txt`

`$ curl -L -s -S http://dx.doi.org/10.7935/K5H41PBP >redirect2.txt`

`$grep "<title>" redirect2.txt`

**Exercise 1A(3). Determine if a 'DOI-style string' is a valid DOI.**`$ curl -L http://10.5454/JPSv1i220161014`

[_Note: this faux DOI was assigned by an established publisher to detect and block unauthorized access to their system. The controversy surrounding publisher creation of DOI-like strings for business operations was taken up in an interesting posting on the CrossRef blog, [DOI-like strings and fake DOIs](http://blog.crossref.org/2016/06/doi-like-strings-and-fake-dois.html)_].  ---
##**Module 1B. Anatomy of the DOI System?**
---
The [DOI System](https://www.doi.org/) is the overall infrastructure by which Digital Object Identifiers are assigned, registered, resolved, and associated with valuable metadata including citation, availability of full text, funder information,  licensing information, and more. The following components of the DOI System together make it work.
* [The International DOI Federation (IDF)](http://www.doi.org/doi_handbook/7_IDF.html) is responsible for the overall governance of the system. IDF is a not-for-profit membership organization that oversees the operations of the federation of Registration Agencies which providing Digital Object Identifier (DOI) services and registration. IDF is also the registration authority for the ISO standard (ISO 26324) for the DOI system.
* [Registration Agencies](https://www.doi.org/registration_agencies.html) provide services to Registrants — allocating DOI name prefixes, registering DOI names and providing the necessary infrastructure to allow Registrants to declare and maintain metadata and state data. Each RA must follow basic protocols and standards of the DOI sytem, including  a minimum metadata standard known as the DOI kernel. Yet each RA has the freedom to implement additional metadata standards, track a range of information about a given DOI resource, and offer public services for querying their databases.  As an example, the Registration Agency CrossRef registers a range of metadata about scholarly resources including funding data, license associated with the digital object, author data including ORCiD numbers, and more -- see April Ondis' CrossRef Blog posting [Beyond the DOI to richer metadata](http://blog.crossref.org/2016/06/beyond-the-doi-to-richer-metadata.html) for more info about their services.
* [Registrants](http://google.com) become members of a given Registration Agency in order to to register DOIs for information resources under their responsibility. Registrants include publishers, data centers, universities, libraries, university presses, and more. Registrants must follow the policies and procedures established by the RA in order to register DOIs. Each Registrant is given a unique code that forms the prefix of the DOI sequence. The Registrant then uses the suffix portion of the DOI sequence to assign unique names to each resource they manage.  For example, CODA serves as publisher for the Data Science Journal. CODATA DOIs for the articles inthis journal share the prefix 10.5334/.

<a href='figures/Figure 1/Figure 1.png'>figures/Figure 1/Figure 1.png</a>
`$ curl http://api.crossref.org/prefixes/10.9751`

**Excercise 1B(2). Given a DOI, determine which Registration Agency issued it**`$ curl http://doi.crossref.org/doiRA/10.5170/CERN-2000-001.101`

`$ curl http://doi.crossref.org/doiRA/10.5170/CERN-2000-001.101, 10.2307/1578389`

[_Note that this lookup service is provided by one of the DOI Agencies, CrossRef, yet the query also works for DOIs issued by other Agencies!  Each DOI Agency provides various services beyond registering and maintaining DOIs; savvy researchers may wish to check with more than one agency to get relevant information._] **Exercise 1B(3). Retrieve a list of DataCite members****Exercise 1C. Determine what information resource is associated with a given DOI**---
##**Module 1C. Metadata associated with DOIs**##
---
When works are registered with DOI Registration Agencies, the Registrant (publisher, data center, or other information provider) is required to submit metadata about the resource that the DOI links to. Each Registration Agency maintains its own metadata schema and establishes rules for requiring and populating the metadata elements so it is important to check their respective websites for a list of metadata elements used and whether they are mandatory or optional.

Each Registration Agency also has the option of offering metadata look up and harvesting services that researchers may openly query. At a minimum, these services provide a basic citation for each DOI-assigned work: creator, title, publisher, publication year, and URL for the landing page of the resource. Additional metadata may include references cited in the work; funding sources; author ORCiD numbers; usage licenses attached to the work; and more.

Researchers may search for metadata associated with DOIs in various ways.  This module demonstrates how to use the API services of two Registration Agencies -- CrossRef and DataCite -- to query and retrieve valuable metadata about research outputs. The commands demonstrated use the process of DOI Content Negotiation to retrieve different representations of a work from the API service.**Exercise 1C(1). Query the Registration Agency API to retrieve a citation for a published article**`$curl http://api.crossref.org/works/http://dx.doi.org/10.1103/PhysRevLett.116.061102 > cite1.txt`

`$less cite1.txt`

_Now use Content Negotation to specify a particular format for the citation._

`$curl -LH "Accept:text/bibliography; style=bibtex" http://dx.doi.org/10.1103/PhysRevLett.116.061102 > cite1.bib`

`$cat cite1.bib`

_Keep this citation for Lesson 2, where we add it to a publications list to include in a new research paper._
---
##**Module 1D. How do I get a Digital Object Identifier (DOI) for my material?**
---

You have two options: 

+ Use the services of an existing Registrant, such as a Publisher, Library, or Data Center who is assisting you with
disseminating and preserving your research outputs. If you aren't working with one of these RAs, you can submit your work to an open research sharing system such as Zenodo where your ubmission is assigned a DOI, archived, and disseminated over the open Web.

+ Alternatively, your organization can join a DOI Registration Agency (RA) and become a DOI Registrant. This commitment requires an investment of time, infrastructure, funds, and human resources to ensure that registered DOIs are maintained and revised as content changes or moves. Information about becoming a DOI registration is available from the DOI Foundation.

[_Note that Zenodo does offer an API service which can be used via Python with the Requests package installed.  Advanced registration with Zenodo is necessary to obtain a authorization token to include in requests._]**Exercise 1D. Look at Zenodo content and see the DOI assigned.**##**References & Additional Readings**##
---

+ curl documentation, 2016.  https://curl.haxx.se/
+ CrossRef REST API, 2016. http://rest-api-doc/rest_api.md
+ Beyond the DOI to richer metadata, CrossRef Blog posting of June 15, 2016 by April Ondis, http://blog.crossref.org/2016/06/beyond-the-doi-to-richer-metadata.html
+ DataCite API, https://api.datacite.org/
+ Digital Object Identifier (DOI) Handbook, https://www.doi.org/hb.html
+ Digital Object Identifier System and DOI Names (DOIs) Guide from Australian National Data Service, http://www.ands.org/guides/doi
+ DOI Citation Formatter beta, http://crosscite.org/citeproc/


`http://api.crossref.org/works?query.author=feynman&query.title=Surely+You're?filter=from-pub-date:1986-01-01`