---
title: "Services"
showAuthor: false
---
<style>
  .services-container {
    max-width: 1000px;
    margin: 0 auto;
    padding: 2rem 1rem;
  }
  .service-category {
    margin-bottom: 2rem;
    text-align: left;
  }
  .service-category h2 {
    margin-bottom: 1rem;
    border-bottom: 1px solid #ddd;
    padding-bottom: 0.25rem;
  }
  .service-buttons {
    display: flex;
    flex-wrap: wrap;
    gap: 1rem;
  }
  .service-button {
    flex: 1 1 200px;
    text-decoration: none;
    padding: 1rem;
    border: 1px solid #ddd;
    border-radius: 5px;
    transition: background 0.2s;
    text-align: center;
    background: transparent;
    color: inherit;
  }
  .service-button:hover {
    background: #2f2f2f;
  }
  .service-icon {
    width: auto;
    height: 40px;
    display: block;
    margin: 0 auto 0.5rem;
  }
  .service-name {
    display: block;
    font-size: 1rem;
    font-weight: bold;
  }
  .service-description {
    display: block;
    font-size: 0.9rem;
    margin-top: 0.5rem;
    color: #666;
  }
</style>

<div class="services-container">
  <h1>Services</h1>

  <!-- Media Category -->
  <div class="service-category">
    <h2>Media</h2>
    <div class="service-buttons">
      {{< service name="Jellyfin" icon="jellyfin.png" href="https://tv.efym.net" description="Watch movies and TV shows" >}}
      {{< service name="Navidrome" icon="navidrome.png" href="https://music.efym.net" description="Listen to music" >}}
      {{< service name="Calibre web" icon="calibre-web.png" href="https://books.efym.net" description="Read books" >}}
      {{< service name="Pinchflat" icon="pinchflat.png" href="https://pinchflat.efym.net" description="YouTube downloader" >}}
    </div>
  </div>

  <!-- Download Category -->
  <div class="service-category">
    <h2>Download</h2>
    <div class="service-buttons">
      {{< service name="Radarr" icon="radarr.png" href="https://radarr.efym.net" description="Download movies" >}}
      {{< service name="Sonarr" icon="sonarr.png" href="https://sonarr.efym.net" description="Download TV shows" >}}
      {{< service name="Prowlarr" icon="prowlarr.png" href="https://prowlarr.efym.net" description="Index manager" >}}
      {{< service name="qBittorrent" icon="qbittorrent.png" href="https://dl.efym.net" description="Torrent client" >}}
    </div>
  </div>

  <!-- Misc Category -->
  <div class="service-category">
    <h2>Misc</h2>
    <div class="service-buttons">
      {{< service name="Authelia (login)" icon="authelia.png" href="https://login.efym.net" description="Identity provider" >}}
      {{< service name="Authelia (logout)" icon="authelia.png" href="https://login.efym.net/logout" description="Identity provider" >}}
      {{< service name="Hoarder" icon="hoarder.png" href="https://hoarder.efym.net" description="Bookmarks manager" >}}
      {{< service name="Linkding" icon="linkding.png" href="https://links.efym.net" description="Bookmarks manager" >}}
      {{< service name="Vaultwarden" icon="vaultwarden.png" href="https://vault.efym.net" description="Password manager" >}}
      {{< service name="Actual Budget" icon="actual-budget.png" href="https://actual.efym.net" description="Finance manager" >}}
    </div>
  </div>

  <!-- Management Category -->
  <div class="service-category">
    <h2>Management</h2>
    <div class="service-buttons">
      {{< service name="Proxmox 1" icon="proxmox.png" href="https://pve.efym.net" description="Hypervisor" >}}
      {{< service name="ArgoCD" icon="argo-cd.png" href="https://argocd.efym.net" description="GitOps for Kubernetes" >}}
      {{< service name="Longhorn" icon="longhorn.png" href="https://longhorn.efym.net" description="Storage management" >}}
      {{< service name="Grafana" icon="grafana.png" href="https://grafana.efym.net" description="Display metrics on dashboards" >}}
      {{< service name="Filestash" icon="filestash.png" href="https://files.efym.net" description="Filesystem browser" >}}
      {{< service name="Backrest" icon="backrest.png" href="https://backrest.efym.net" description="Backups management" >}}
    </div>
  </div>

  <!-- Network Category -->
  <div class="service-category">
    <h2>Network</h2>
    <div class="service-buttons">
      {{< service name="Traefik" icon="traefik.png" href="https://traefik.efym.net" description="Ingress controller" >}}
      {{< service name="OpenWrt" icon="openwrt.png" href="https://openwrt.efym.net" description="Routing and firewall" >}}
      {{< service name="TrueNAS" icon="truenas.png" href="https://truenas.efym.net" description="Network attached storage" >}}
      {{< service name="Adguard Home 1" icon="adguard-home.png" href="https://adguard1.efym.net" description="DNS rewrites and blocks" >}}
      {{< service name="Adguard Home 2" icon="adguard-home.png" href="https://adguard2.efym.net" description="DNS rewrites and blocks" >}}
      {{< service name="WireGuard" icon="wireguard.png" href="https://wireguard.efym.net" description="VPN and exit node" >}}
    </div>
  </div>

  <!-- Local Area Network Category -->
  <div class="service-category">
    <h2>Local area network</h2>
    <div class="service-buttons">
      {{< service name="Proxmox" icon="proxmox.png" href="http://atlas.lan:8006" description="Hypervisor" >}}
      {{< service name="OpenWrt" icon="openwrt.png" href="http://quack.lan" description="Routing and firewall" >}}
      {{< service name="TrueNAS" icon="truenas.png" href="http://scale.lan" description="Network attached storage" >}}
      {{< service name="Adguard Home 1" icon="adguard-home.png" href="http://psi.lan:8083" description="DNS rewrites and blocks" >}}
      {{< service name="Adguard Home 2" icon="adguard-home.png" href="http://isp.lan:8083" description="DNS rewrites and blocks" >}}
    </div>
  </div>

  <!-- Syncthing Category (no descriptions) -->
  <div class="service-category">
    <h2>Syncthing</h2>
    <div class="service-buttons">
      {{< service name="mirage" icon="syncthing.png" href="http://mirage.lan:8384" >}}
      {{< service name="wesley" icon="syncthing.png" href="http://wesley.lan:8384" >}}
      {{< service name="scale" icon="syncthing.png" href="http://scale.lan:8384" >}}
      {{< service name="laser" icon="syncthing.png" href="http://laser.lan:8384" >}}
    </div>
  </div>

</div>
