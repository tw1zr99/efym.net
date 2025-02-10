---
title: "Support"
showAuthor: false
---
<style>
  .max-w-prose {
    max-width: 100%;
  }
  .support-container {
    max-width: 800px;
    margin: 0 auto;
    padding: 2rem 1rem;
    text-align: center;
  }
  .donation-grid {
    display: flex;
    flex-wrap: wrap;
    gap: 2rem;
    justify-content: center;
  }
  .donation-card {
    flex: 1 1 250px;
    max-width: 200px;
    padding: 1rem;
    background: transparent;
    border: none;
    box-shadow: none;
    text-align: center;
  }
  .donation-card h3 {
    margin: 0.5rem 0;
    font-size: 1.2rem;
  }
  .donation-card .crypto-icon {
    width: 40px;
    height: auto;
    display: block;
    margin: 0 auto 1rem;
  }
  .donation-card .qr-code {
    width: 150px;
    height: auto;
    margin: 0.5rem auto;
    display: block;
  }
  .donation-card .crypto-address {
    font-family: monospace;
    font-size: 0.9rem;
    word-break: wrap;
  }
</style>

<div class="support-container">
  <p>Your support helps keep this site running smoothly! Please consider sending a cryptocurrency donation:</p>

  <div class="donation-grid">
    {{< support crypto="Monero" icon="/support/xmr.png" qr="xmr-qr.svg" address="82muL9wgujG7RkgxzNFzin89if7GYNbQKVxQwArx77U35uTdXN4iRNYhCq1oBRxHT8TiGo4Wh8BSp6ZZZCxUY3G2Qo3hU6Q" >}}
    {{< support crypto="Bitcoin" icon="/support/btc.png" qr="btc-qr.png" address="bc1qa6cfruw6a5n7wda27mfs99qvn75ndyslp6xucx" >}}
    {{< support crypto="Ethereum" icon="/support/eth.png" qr="eth-qr.svg" address="0x8e3D0ef62cb6ce59Acd702e2c0Ff8a128551B2c6" >}}
  </div>
</div>
