# docker-registry


Create a dns record for registry.dillan.io and register the route with cloudflared

```bash
cloudflared tunnel route dns k8s registry.dillan.io
```