# nix-server

A basic **NixOS** configuration to serve static content and web servers using **Nginx**.

---

---

# introduction

The project aims to introduce a less "opened" setup, from initial and default packages configurations following the **deny-by-default** principle.

Some basic `programs` have been added as tools and utils (see `./configuration.nix`).

All files may be verified and their configuration changed accordingly (users, `ssh` keys, etc).# nix-server

A basic **NixOS** configuration to serve static content and web servers using **Nginx**.

### ssh

See `./modules/ssh.nix`.

Default port is set to use `1234`, though anything other than `22` would be suggested.

Authentication for `ssh` is only possible using a `ssh-key` (no password allowed), following specific formats (`ED25519` used here).

### networking

See `./modules/networking.nix`.

`firewall` is enabled.  
`dhcp` is disabled, also per interface - a **static** address has been set.

No allowed **TCP** and **UDP** ports is listed by default.  
These must be declared per interface.  
The **default interface** may only needs to open `ssh` port and port `80` (`443` for **SSL**).  
The **loopback interface** (e.g `localhost`) may open various ports for all runnning applications.

### users

See `./modules/users.nix`.

**1 default user** and its group are created during installation, given `wheel` permission (similar to `root`).

`root` password has also been set to `""` to prevent login.

### nginx

See `./modules/nginx.nix`.

**Nginx** is used to serve static content and as **reverse-proxy**.  
**reverse-proxy** method may be preferred and recommended.

Default configuration will `deny all` access to the host default address (`0.0.0.0`).  
Acessing the host will give a `403` status.

**Domain names** are to be used instead to serve content or additional **static** addresses.

---

---

# sites

See `./sites/`.

**2 sites** are given as example and served with **Nginx**:

| name    | domain           |                                                         |
| ------- | ---------------- | ------------------------------------------------------- |
| `app-1` | `app-1.nix-host` | a static `index.html`                                   |
| `app-2` | `app-2.nix-host` | a `node` app using `express.js` through a reverse-proxy |

Additional `systemd` service and `activationScript` have been created to build and run projects (e.g copy files, install dependencies, etc...).

---

---

# documentation & links

- https://nixos.wiki/wiki/Nginx

### ssh

See `./modules/ssh.nix`.

Default port is set to use `1234`, though anything other than `22` would be suggested.

Authentication for `ssh` is only possible using a `ssh` key (no password allowed), following specific formats (`ED25519` used here).

### networking

See `./modules/networking.nix`.

`firewall` is enabled.  
`dhcp` is disabled, also per interface - a **static** address has been set.

No allowed **TCP** and **UDP** ports is listed by default.  
These must be declared per interface.  
The **default interface** may only needs to open `ssh` port and port `80` (`443` for **SSL**).  
The **loopback interface** (e.g `localhost`) may open various ports for all runnning applications.

### users

See `./modules/users.nix`.

**1 default user** and its group are created during installation, given `wheel` permission (similar to `root`).

`root` password has also been set to `""` to prevent login.

Default user name is `host` and password `123`.

### nginx

See `./modules/nginx.nix`.

**Nginx** is used to serve static content and as **reverse-proxy**.  
**reverse-proxy** method may be preferred and recommended.

Default configuration will `deny all` access to the host default address (`0.0.0.0`).  
Acessing the host will give a `403` status.

**Domain names** are to be used instead to serve content or additional **static** addresses.

---

---

# sites

See `./sites/`.

**2 sites** are given as example and served with **Nginx**:

| name    | domain           |                                                         |
| ------- | ---------------- | ------------------------------------------------------- |
| `app-1` | `app-1.nix-host` | a static `index.html`                                   |
| `app-2` | `app-2.nix-host` | a `node` app using `express.js` through a reverse-proxy |

Additional `systemd` service and `activationScript` have been created to build and run projects (e.g copy files, install dependencies, etc...).

---

---

# documentation & links

- https://nixos.wiki/wiki/Nginx
