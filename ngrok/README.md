# Hass.io ngrok 3 Client

A ngrok 3 client for Hass.io

## About

This add-on creates a ngrok tunnel over http and https. It also provides a
RESTful API that can be used to integrate your tunnel status into Home Assistant.
Some ISPs do not allow port forwarding due to port blocking or CG-NAT. If you're
able to setup a port forward, do not use this addon.

**Note**: _ngrok could man-in-the-middle your http tunnels if they wanted.
          Using a TLS tunnel will prevent this because you can control the certificate.
          To use some features of this add-on, you need a paid ngrok account._

[github_link]: https://github.com/dy1io/hassio-ngrok/issues
