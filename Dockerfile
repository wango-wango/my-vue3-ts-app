# 使用 Node 18 作為基底映像
FROM node:18 AS build

# 設定工作目錄
WORKDIR /app

# 複製 package.json 和 package-lock.json 來安裝依賴
COPY package*.json ./

# 安裝專案的依賴
RUN npm install

# 複製所有檔案到容器中
COPY . .

# 建立專案
RUN npm run build

# 用於運行 Nginx 的階段
FROM nginx:latest

# 複製編譯後的靜態文件到 Nginx 目錄
COPY --from=build /app/dist /usr/share/nginx/html

# 複製 Nginx 配置檔案
COPY nginx.conf /etc/nginx/nginx.conf

# 暴露 Nginx 端口
EXPOSE 80

# 啟動 Nginx
CMD ["nginx", "-g", "daemon off;"]
