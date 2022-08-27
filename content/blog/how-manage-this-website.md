---
title: "How I manage this website"
date: 2021-10-29T11:16:10+01:00
tags: [ 'html', 'bash' ]
---
Run-down of the process and tools I use to keep efym.net running.

* * *

{{< update-manage-website>}}

* * *

## Static site generation

Back when I was around 10 years old one of my older cousins showed me how to make very simple web pages by writing the **html** tags directly into a file with notepad. Now many years later I still write my own **html** code instead of using frameworks, all I need is **vim** to make a website; granted it wouldn't be anywhere near as fancy of something produced with **Wordpress** or **Joomla** but to me that's a plus. I despise how bloated the modern web is which is why my website is kept intentionally simple.

All that being said, it would be a major pain in the ass and totally unnecesary to write every single web page from scratch by hand, so when I first created **efym.net** I looked around to make a choice about which static site generator I was going to use. Very much to my surprise I found **ssg**, a very simple script written in **bash** which does something very close to what I wanted: it takes a header and a footer file and wraps every other file in the designated directory with them. There are a couple other things it does but none of them really concern me. No bloat, no JavaScript, no themes, etc.

It supports **markdown** to **html** conversion too, so if one was inclined to write the pages in markdown one could do that. All you need to do to run it is make a couple of directories, one with source files and one which acts as the destination one, this last directory's content is ready to be put in your web server.

There are detailed instructions on **ssg**'s website, which you can visit at:  
[https://www.romanzolotarev.com/ssg.html](https://www.romanzolotarev.com/ssg.html)  
But as an example this is what I would run to generate the website files for the first time or after modifying something:

```
$ ssg6 src dst "efym" "https://efym.net"
```

Before I **rsync** the **dst** directory to the server which hosts my website I like to check everything is looking the way I want it, so I host a simple **http** server with a **Python** module right from the computer I'm working on for testing purposes, this can be achieved by changing into the **dst** directory and issuing the following command:

```
$ python -m http.server 8080
```

Then just open any web browser and point the url to **localhost:8080**.

## Deployment script

As good as **ssg** is as a static site generator, it's still missing some very specific things, I wanted a "Recent articles" section at the bottom of the **index.html** page which automatically selected the most recent 2-3 blog posts I'd written and displayed links to them. I also wanted the **blogindex.html** page to be generated with entries linking to every blog post inside the **blog** directory. So in order to not have to add and change these entries manually everytime I write a new blog post, I wrote a wrapper script to take care of it, here is what it looks like:

**`$ cat deploy-site`**
```
#!/bin/bash

[[ -f ./deploy-site ]] || exit 1

posts=$(grep -m1 the_index src/blog/*.html | sort -g -r -k2 -t = | cut -d\: -f1 | cut -d\/ -f3)
posts_recents=$(grep -m1 the_index src/blog/*.html | sort -g -r -k2 -t = | cut -d\: -f1 | cut -d\/ -f3 | head -n3)

# generate/update blog entries in blogindex.html
echo "<center><a href='/feed' type='application/rss+xml'><img class='icon' src='/img/rss_icon.png'> RSS feed</a></center>" > src/blogindex.html
for post in ${posts}; do
	title=$(grep '<h1>' src/blog/$post | sed 's|</*h1>||g')
	desc=$(grep '<p class="desc">' src/blog/$post | sed 's|</*p>||g' | sed 's|<p class="desc">||g')
	datt=$(grep '<p class="date">' src/blog/$post | sed 's|</*p>||g' | sed 's|<p class="date">||g')
	echo "<p class="date">$datt</p>" >> src/blogindex.html
	echo "<a href="blog/${post}">$title</a>" >> src/blogindex.html
	echo "<p class="desc">$desc</p>" >> src/blogindex.html
	echo "<hr>" >> src/blogindex.html
done

# generate/update rss feed
echo "<?xml version='1.0' encoding='utf-8'?>" > src/feed
echo "<rss version='2.0'>" >> src/feed
echo "<channel>" >> src/feed
echo "<title>efym.net</title>" >> src/feed
echo "<description>you can't escape from your mind</description>" >> src/feed
echo "<link>https://efym.net</link>" >> src/feed
for post in ${posts}; do
	title=$(grep '<h1>' src/blog/$post | sed 's|</*h1>||g')
	desc=$(grep '<p class="desc">' src/blog/$post | sed 's|</*p>||g' | sed 's|<p class="desc">||g')
	datt=$(grep '<p class="date">' src/blog/$post | sed 's|</*p>||g' | sed 's|<p class="date">||g')
	rssdatt=$(date -R --date="$datt")
	echo "<item>" >> src/feed
	echo "<guid>https://efym.net/blog/$post</guid>" >> src/feed
	echo "<link>https://efym.net/blog/$post</link>" >> src/feed
	echo "<pubDate>$rssdatt</pubDate>" >> src/feed
	echo "<title>$title</title>" >> src/feed
	echo "<description>$desc</description>" >> src/feed
	echo "</item>" >> src/feed
done
echo "</channel>" >> src/feed
echo "</rss>" >> src/feed

# updates "recent articles" list of blog entries in index.html
sed -i '1,/the_recents/!d' src/index.html
for post in ${posts_recents}; do
	title=$(grep '<h1>' src/blog/$post | sed 's|</*h1>||g')
	echo "<li><a href='/blog/${post}'>$title</a></li>" >> src/index.html
done
echo "<p></p>" >> src/index.html
echo "<a href='/feed' type='application/rss+xml'><img class='icon' src='/img/rss_icon.png'> RSS feed</a><br>" >> src/index.html
echo "</ul>" >> src/index.html

# ssg6 rebuild static pages
rm dst/.files
ssg6 src dst "efym" "https://efym.net"

# rsync everything to efym server
read -r -p "deploy to efym.net server? [y/N] " input
case $input in
	[yY][eE][sS]|[yY]) rsync -avhP --delete --chown=www-data:www-data ./dst/ root@efym.net:/var/www/efym.net/ ;;
	*) echo "not deploying" ;;
esac
```

The script has comments at the beginning of each section, so it should be fairly easy to identify exactly how I accomplish the tasks mentioned before (provided the reader is familiar with **bash**).

Another thing I wanted to have automatically generated based on the current available posts is an **RSS** feed. I personally use **RSS** all the time to keep up with various news, videos, etc. I think **RSS** is very understimated nowadays but since I use it I wanted my site to prioritize it. So the **deploy-site** wrapper script also generates an **RSS** feed and adds links to it at the top of the **blogindex.html** page and in the "Recent articles" section in the **index.html** page.  
The **RSS** feed links point here: [https://efym.net/feed](/feed) and can be accessed with any available client.

After all those things are done, the script rebuilds the site files using **ssg** then prompts me whether I'd like to **rsync** the **dst** directory straight to the server hosting the website on the Internet, usually I'll run the script many times before I actually upload the work I've done.

I also keep all of these files in a **git** repository on my **Gitea** instance: [gitea.efym.net/efym.net-ssg](https://gitea.efym.net/tw1zr/efym.net-ssg) feel free to browse, everything is Free Software under the **GPLv3** license.
