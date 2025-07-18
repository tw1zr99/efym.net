---
title: "Services"
showAuthor: false
---
<style>
  .prose {
    max-width: 100%;
  }
  .max-w-prose {
    max-width: 100%;
  }
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
    border: 2px solid rgba(91, 104, 153, 0.22);
    border-radius: 10px;
    transition: background 0.2s;
    text-align: center;
    background: transparent;
    color: inherit;
  }
  .service-button:hover {
    background: rgba(39, 53, 77, 0.9);
    border-radius: 10px;
    box-shadow: 0 0 8px rgba(47, 47, 47, 0.2);
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
    color: #e4e4e4;
  }
</style>

<div class="services-container">

  <!-- Media Category -->
  <div class="service-category">
    <h2>Media</h2>
    <div class="service-buttons">
      {{< service name="Jellyfin" icon="jellyfin.png" href="https://tv.efym.net" description="Watch movies and TV shows" >}}
      {{< service name="Navidrome" icon="navidrome.png" href="https://music.efym.net" description="Listen to music" >}}
      {{< service name="Calibre web" icon="calibre-web.png" href="https://books.efym.net" description="Read books" >}}
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
      {{< service name="Pinchflat" icon="pinchflat.png" href="https://pinchflat.efym.net" description="YouTube downloader" >}}
    </div>
  </div>

  <!-- Misc Category -->
  <div class="service-category">
    <h2>Misc</h2>
    <div class="service-buttons">
      {{< service name="Authelia (login)" icon="authelia.png" href="https://login.efym.net" description="Identity provider" >}}
      {{< service name="Authelia (logout)" icon="authelia.png" href="https://login.efym.net/logout" description="Identity provider" >}}
      {{< service name="Karakeep" icon="karakeep.png" href="https://links.efym.net" description="Bookmarks manager" >}}
    </div>
  </div>

  <!-- Management Category -->
  <div class="service-category">
    <h2>Management</h2>
    <div class="service-buttons">
      {{< service name="Proxmox 1" icon="proxmox.png" href="https://pve.efym.net" description="Hypervisor" >}}
      {{< service name="Proxmox 2" icon="proxmox.png" href="https://pve2.efym.net" description="Hypervisor" >}}
      {{< service name="Proxmox Backup Server" icon="proxmox.png" href="https://pbs.efym.net" description="Hypervisor backups" >}}
      {{< service name="Longhorn" icon="longhorn.png" href="https://longhorn.efym.net" description="Storage management" >}}
      {{< service name="Grafana" icon="grafana.png" href="https://grafana.efym.net" description="Display metrics on dashboards" >}}
      {{< service name="Filestash" icon="filestash.png" href="https://files.efym.net" description="Filesystem browser" >}}
    </div>
  </div>

  <!-- Network Category -->
  <div class="service-category">
    <h2>Network</h2>
    <div class="service-buttons">
      {{< service name="Traefik" icon="traefik.png" href="https://traefik.efym.net" description="Ingress controller" >}}
      {{< service name="OpenWrt" icon="openwrt.png" href="https://openwrt.efym.net" description="Routing and firewall" >}}
      {{< service name="TrueNAS" icon="truenas.png" href="https://truenas.efym.net" description="Network attached storage" >}}
      {{< service name="Adguard Home 1" icon="adguard-home.png" href="https://adguard.efym.net" description="DNS rewrites and blocks" >}}
      {{< service name="Adguard Home 2" icon="adguard-home.png" href="https://adguard2.efym.net" description="DNS rewrites and blocks" >}}
      {{< service name="Netbird" icon="netbird.png" href="https://netbird.efym.net" description="Overlay network" >}}
    </div>
  </div>

  <!-- Local Area Network Category -->
  <div class="service-category">
    <h2>Local area network</h2>
    <div class="service-buttons">
      {{< service name="Proxmox 1" icon="proxmox.png" href="http://atlas.lan:8006" description="Hypervisor" >}}
      {{< service name="Proxmox 2" icon="proxmox.png" href="http://hades.lan:8006" description="Hypervisor" >}}
      {{< service name="Proxmox Backup Server" icon="proxmox.png" href="http://venus.lan:8006" description="Hypervisor backups" >}}
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
