# nginx-reverse-proxy
A very simple reverse proxy using nginx and Docker

```
docker run -p 1234:80 --env UPSTREAM_HTTP_ADDRESS='https://caprover.com' caprover/nginx-reverse-proxy
```


Open `http://localhost:1234` in your browser.

Set `NGINX_RESOLVER_IPV6=on` to resolve AAAA records for upstream hostnames. The default is `off`. The container needs IPv6 connectivity to reach IPv6 upstreams.
