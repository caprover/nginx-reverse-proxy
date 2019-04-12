# nginx-reverse-proxy
A very simple reverse proxy using nginx and Docker

```
docker run -p 1234:80 --env UPSTREAM_HTTP_ADDRESS='https://caprover.com' caprover/nginx-reverse-proxy
```


Open `http://localhost:1234` in your browser.
