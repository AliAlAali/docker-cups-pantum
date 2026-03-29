FROM debian:bookworm

ENV DEBIAN_FRONTEND=noninteractive

# Install CUPS + drivers
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        cups \
        cups-client \
        cups-bsd \
        cups-browsed \
        printer-driver-gutenprint \
        hplip \
        ipp-usb \
        dbus \
        avahi-daemon \
        sudo \
        ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create required directories
RUN mkdir -p /var/run/cups

# Copy configuration
COPY cupsd.conf /etc/cups/cupsd.conf
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

EXPOSE 631

ENTRYPOINT ["/entrypoint.sh"]