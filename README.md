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
**Note:** make sure to add/remove the IP addresses in cupsd.conf for web portal to reflect your actual docker network IP
```conf
# Protect printers
<Location /printers>
  Order allow,deny
  Allow 192.168.0.0/16 # Example: add your network subnet mask
  Allow 172.17.0.0/16
</Location>
```
```bash
docker build --network=host -t docker-cups-server ./
```

### Configure Printer
After starting the container, the CUPS web interface will be available at:

> **URL:** `http://<YOUR_DOCKER_IP>:631`

1. Open your browser and go to the address above.
2. Use the credentials defined in your environment variables:
   * **User:** `${CUPS_ADMIN_USER}`
   * **Password:** `${CUPS_ADMIN_PASSWORD}`

<img width="674" height="454" alt="image" src="https://github.com/user-attachments/assets/e820b107-6220-4f62-8055-d989b9437ecd" />

