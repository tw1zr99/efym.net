---
title: "Support"
showAuthor: false
---

<style>
  .support-container {
    /*max-width: 800px;*/
    margin: 0 auto;
    /*padding: 2rem 1rem;*/
    text-align: center;
  }
  .donation-grid {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 1.5rem;
  }
  .donation-card {
    background-color: #1f2937;
    border: 1px solid #e4e4e4;
    border-radius: 10px;
    padding: 1rem;
    /*width: 260px;*/
    /*box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);*/
    /*transition: transform 0.2s ease, box-shadow 0.2s ease;*/
  }
  .donation-card h3 {
    /*margin: 0.5rem 0;*/
    font-size: 1.2rem;
  }
  .donation-card .crypto-icon {
    width: 40px;
    height: auto;
  }
  .donation-card .qr-code {
    width: 150px;
    height: auto;
    margin: 0.5rem auto;
  }
  .donation-card .crypto-address {
    font-family: monospace;
    font-size: 0.9rem;
    word-break: break-all;
    background: #1f2937;
    border-radius: 5px;
  }
</style>

<div class="support-container">
  <p>Your support helps keep this site running smoothly! Please consider sending a cryptocurrency donation:</p>

  <div class="donation-grid">
    {{< support crypto="Monero" icon="/support/xmr.png" qr="/support/qr_xmr.png" address="82muL9wgujG7RkgxzNFzin89if7GYNbQKVxQwArx77U35uTdXN4iRNYhCq1oBRxHT8TiGo4Wh8BSp6ZZZCxUY3G2Qo3hU6Q" >}}

  </div>
</div>
