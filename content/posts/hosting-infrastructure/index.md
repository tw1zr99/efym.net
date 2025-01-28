---
title: "Hosting Infrastructure"
date: 2020-08-22T10:26:54+01:00
tags: ['privacy', 'linux', 'vps', 'hosting']
---
#### Trying to move into a server that gives better control over VPS boxes while retaining the privacy given by no-account, no sign-up and crypto payed deployments.
* * *

{{< alert " " >}}
**Disclaimer:** This is a shill-free zone. I have NOT been paid a cent to advertise any service/company being discussed here nor do I want to or would accept it.
{{< /alert >}}

For the longest time I've been using [Sporestack](https://sporestack.com) to host my services and website. Now, [Sporestack](https://sporestack.com) isn't perfect at all, it uses various bad-actor services as infrastructure, especially DigitalOcean. The good thing about it is that you do not need to register any accounts and all payment is done in crypto, their API is also pretty sweet and can be used through the **sporestack** pip package directly from the CLI (right up my alley).
The drawbacks are obvious though, you can't control where boxes will be hosted and you don't "own" them, merely using an API which acts as a reseller; you can't externally monitor bandwidth usage or anything else which would require physical access to the hypervisor, not to mention the price is a bit steep. I still quite like [Sporestack](https://sporestack.com) though and for intentionally short lived boxes I think it's perfect. But recently I started looking for alternatives with more control and flexibility over spun up boxes.

## Here are some of the criteria I considered:

- Amount of Personal information required
- Cryptocurrencies for payment (Monero preferably)
- Privately owned (with no investors or ad campaigns)
- Country of jurisdiction
- GDPR compliance (at least)
- Price (least important although not negligible)

Having these requirements, the big 3 hosting companies (being DigitalOcean, Vultr and Linode) are a no-go.
All three would straight up ask for full name, phone number, full address and even though cryptos are acceptable as payment in some instances, you would first have to fund the account with a credit card or Paypal; hilariously invasive. Linode even goes as far as to ask for a picture of valid ID, I almost spill the whisky I was sipping when I read that email. Disgusting.

Since I use [Njalla](https://njal.la) as a domain registrar I obviously considered them to host my boxes seeing as they also provide that service, but port 25 is kept blocked in their instances, to eliminate spam originating from their servers presumably, but I host my own email server so outbound port 25 is a personal requirement of mine.

{{< alert " " >}}
**Note:** Having used them for over 2 years I highly recommend [Njalla](https://njal.la) as a registrar, and if you don't self host email and instead use something like [Migadu](https://migadu.com) then their VPS boxes are perfectly fine as well.
{{< /alert >}}

During my research I didn't come accross many companies which met even the first criteria (No personal info required for signing up and deployment). In fact, I almost gave up and was about to keep using [Sporestack](https://sporestack.com) for the foreseeable future until I stumbled across this:

## The solution

**[1984hosting](https://1984hosting.com)** requires zero personally identifiable information in order to sign up, phone number is optional and only in case you need tech support, which we don't; is privately owned and the owner is actively involved in free speech rights campaigns. The country in which its data-centers reside is Iceland: arguably the best jurisdiction on the planet regarding privacy and free speech laws. Okay, this is epic.
Even the price is excellent, comparable with bigger and much better funded solutions. Bitcoin is also accepted as a form of payment, Monero would be perfect but I can settle for using [xmr.to](https://xmr.to)

![](/hosting-infrastructure/1.png) picture from their website

As it stands today most everything I host for myself (not work related) is still in [Sporestack](https://sporestack.com) but over the next couple weeks I'll be migrating everything over to [1984hosting](https://1984hosting.com) and will update this post with results.
