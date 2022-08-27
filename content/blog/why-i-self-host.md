---
title: "Why I self-host everything I can"
date: 2021-09-25T07:16:50+01:00
tag: [ 'privacy' ]
---
Thoughts on why I host the services I use.

* * *

## Opening remarks

Everyone who knows me or has interacted with me in a meaningful way is aware of my disdain towards major corporations, especially the ones that focus in technology. Most of the reasons for this are more ethical and philosophical in nature than born out of practicality, convenience or economic/monetary incentives.  

This is to say I don't disagree they're exceptionally good at what they do or produce, however I think what they do and produce is detrimental to human liberty and society as a whole too, in most cases.

## Chat software

A very good example of the previous statements is WhatsApp; it has a very good feature set, it's simple to use and the servers backing it are excellent in quality, speed and stability; so it's very rare that one would experiece an interruption of service while using it. Same thing can be said of Snapchat, Facebook Messenger, Telegram, WeChat etc.  
My problems with them are not that they're not a _good_ product, the problems are that everything you type/do/say/share is being archived by the company who owns the software and utilized to serve you ads which are tailored to your specific interests thus maximizing profits, dissuade/sensor your opinion in political or social matters, build a profile about you outlining every single personal characteristic you have, even things like "at what time of day are you more likely to go to the bathroom" are possible for these companies to deduce by correlating information about you on their various sites and analyzing it through machine learning.

Not to mention that these applications themselves are propietary software whose source code is not available publicly. So despite all the claims the companies makes about respecting users' privacy, it's impossible for an independant party to verify the veracity of their words.  
And as if not being able to verify what they say wasn't enough (it's enough to not trust them) every single piece of evidence points to the contrary; from Wireshark traffic captures to fines issued to Google, Apple and Facebook from the US government. These companies have been caught time and time again breaking their users' trust.  
Those are my biggest concerns about software by major corporations.

But I would still like to be able to communicate through the Internet, so I host a [Matrix](https://matrix.org) server with [Element](https://element.io) as a web front-end. These are two pieces of free and open source software whose source code you can read and verify nothing malicious is happening behind the scenes.  
Every single person with whom I communicate with any kind of regularity has an account there. If someone in my life wants to talk to me they know—or will be made aware that—that's the way of reaching me; if they refuse to use anything other than the mainstream platforms they use then I know I won't be keeping in touch with them.  

This attitude may sound very radical, and to some extent it is, but for me it's very important to keep my actions aligned with my beliefs (putting my money where my mouth is, so to speak). If I strongly feel a certain way about a certain topic but act in a manner which doesn't relfect it I'd be a hypocrite; and that's something I'd very much rather avoid.

## Websites and Internet real estate

Another one of the reasons why I'm very opposed to the major tech companies in the world is because of how monolithic they have made the modern Internet. An majority percentage of the total Internet traffic goes to the same 10-15 websites, which of course are all owned by these companies. This allows them to push whatever narrative they choose into the minds of gullible people (which most are) but also since their reach is so massive they can alter real life events and their perception, thus creating a sort of information monopoly.

This was not the case 10 years ago. When the current all-encompassing nature of the Internet wasn't fully realized yet, people visited many different websites around the Internet, most of which were personal sites controlled by a single person; perhaps with less quality but certainly less subjected to ideas used mainly to futher the agenda of a corporation or for raw profits.

That's why I host my own website. I want to contribute to the few that still think the Internet should be more chaotic and less sanitized. Power and control of information should be more spread out among the people, not in the hands of billionaires.

I believe every person should have a website they control. Most people actually _think_ they do because they have a Facebook page or an Instagram feed or some Snapchat whatever wherein they express themselves, but to me this is not ideal for reasons already discussed. What happens when the company that owns your so called "page" decides to close your account for good or bad reasons (which are entirely up to them), you wouldn't be able to do anything to stop it, if you had your own personal website however, this would not happen.

## E-mail

Sigh... e-mail servers are such a pain in the ass. Every sysadmin in the world knows this, there are many pieces that need to be in sync with each other and you will be put on a blacklist at the first sight of anything even remotely resembling spam coming from your server, on top of that the protocols are not secure by default.  
Most of this is true because e-mail was never designed with security in mind, it's a very old set of protocols that has stuck around too long, to the point where it is probably the most essential method of communication and verification for the mayority of the Internet.

It's especially important to remember these things when sending any important information through e-mail which hasn't been encrypted, the contents of e-mails are plain text and anyone sniffing your traffic will be able to read them, your ISP is 100% doing it, for example. So I advice to use something like **PGP** to encrypt sensitive emails.

When I think about e-mail servers I picture myself at a shooting range in a life-or-death scenario in which I have to hit a bullseye on every target. But those targets are moving, the building is on fire and I'm tripping on acid; also instead of a gun I'm using a slingshot.  

You might ask: "so if hosting and managing your own e-mail server is so annoying then why should I do it?" and depending on your level of computer literacy and willingness to spend time on it the answer to that question will vary wildly from person to person.

My own personal reasons are briefly discussed above, but adding to that I also:  
like a challenge,  
like computers  
and value my privacy.  
Any and every e-mail provider on the Internet can absolutely read your e-mails, no exceptions. Protonmail is a meme, Tutanota is a meme, they all serve you straight up lies at best and at worst are a government honeypot. And that's just referring to the ones that claim to be private, not to something like Gmail, Hotmail and whatever Apple calls their e-mail service nowadays; these last ones are a complete joke when it comes to privacy.  
FAGMAN (**F**acebook, **A**pple, **G**oogle, **M**icrosoft, **A**mazon and **N**etflix) are the devil incarnate and their terms of service are the contract you sign to sell your soul.  
If you must use e-mail and know your way around Linux then I personally think self-hosting an e-mail service like any and every other service you use is the best solution if privacy is of importance.

Vincent Canfield of [cock.li](https://cock.li) has on his website a paragraph and a quote apparently taken from 4chan which are quite apt to describe what I'm trying to say about e-mail:

![](/blog/why-i-self-host/1.png)

There are also more specific services I host on the Internet or at home (always in a server which I have root access to) and the reason for those are largely the same ones I've already explained.
