# Vue 3 + TypeScript + Vite + Docker + Nginx

## 本專案使用 Vue 3 + TypeScript 開發前端應用。整體架構使用 Docker 進行容器化，並透過 Nginx 進行靜態資源提供與反向代理。

### 如何啟動專案？

### 建置與啟動容器

```
docker-compose up --build -d
```

### 查看運行中的容器

```
docker ps
```

應該會看到 app 和 nginx 兩個容器在運行。

### 打開瀏覽器測試

前端應用 → http://localhost:9001

API（如果有）→ http://localhost:9001/api/

### 反向代理的應用場景

本專案示範了 Nginx 反向代理 的應用，若有後端 API，可透過以下方式代理：

```
location /api/ {
    proxy_pass http://backend_server:3001/;
    proxy_http_version 1.1;
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
}
```

如果 backend_server 是一個使用 Node.js (Nuxt/Next) 撰寫的 API 服務，那麼 /api/ 路由的請求將會轉發到該服務。