# docker-cups-pantum
A lightweight, Dockerized CUPS printing server pre-configured with Pantum printer IPP drivers over IPP USB and IPP support for seamless network printing.

## Automatic Discovery (mDNS/Avahi)
This image uses **Avahi** to broadcast printer services over the network. 
* **Windows/macOS:** The printer will appear automatically in the "Add Printer" dialog.
* **Protocol:** Uses Internet Printing Protocol (IPP) over port 631.
* **Note:** For mDNS to work, the container **must** run in `network_mode: host` or have the DBus socket mapped from the host.

## Setup Requirements

### Environment Variables
Configure these variables in your `docker-compose.yml` or `.env` file to secure the web interface:

| Variable | Description |
| :--- | :--- |
| `CUPS_ADMIN_USER` | Username for the CUPS web admin panel. |
| `CUPS_ADMIN_PASSWORD` | Password for the CUPS web admin panel. | 

### Quick Start (Docker Compose)
Create a `docker-compose.yml` file:

```yaml
version: '3.8'
services:
  cups:
    image: your-username/docker-cups-pantum
    container_name: cups-server
    restart: always
    network_mode: host  # Required for Avahi mDNS broadcasting
    environment:
      - CUPS_ADMIN_USER=pantum_admin
      - CUPS_ADMIN_PASSWORD=secure_password_123
    volumes:
      - ./config:/etc/cups
      - /var/run/dbus:/var/run/dbus  # Required for Avahi communication
    devices:
      - /dev/bus/usb:/dev/bus/usb    # Required if printer is USB-connected
```

### Build your own image
```bash
docker build --network=host -t docker-cups-server ./
```
