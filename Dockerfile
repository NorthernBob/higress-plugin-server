# 构建阶段：处理插件和元数据
FROM python:3.11-alpine AS builder

# 安装系统依赖
RUN apk add --no-cache \
    wget \
    ca-certificates \
    && update-ca-certificates

# 安装 ORAS 客户端
RUN set -eux; \
    ORAS_VERSION="1.2.3"; \
    ARCH=$(uname -m | sed 's/x86_64/amd64/;s/aarch64/arm64/'); \
    wget -O /tmp/oras.tar.gz "https://github.com/oras-project/oras/releases/download/v${ORAS_VERSION}/oras_$(echo ${ORAS_VERSION})_linux_${ARCH}.tar.gz" \
    && tar -zxvf /tmp/oras.tar.gz -C /usr/local/bin \
    && rm -rf /tmp/oras.tar.gz oras \
    && oras version

# 创建工作目录
WORKDIR /workspace

# 复制脚本
COPY pull_plugins.py generate_metadata.py plugins.properties ./

# 执行构建操作
RUN python3 pull_plugins.py 

# 运行阶段：最终镜像
FROM docker.io/nginx:alpine

# 从构建阶段复制生成的文件
COPY --from=builder /workspace/plugins /usr/share/nginx/html/plugins

# 复制 Nginx 配置
COPY nginx.conf /etc/nginx/nginx.conf

# 暴露端口
EXPOSE 8080

# 启动 Nginx
CMD ["nginx", "-g", "daemon off;"]