# higress-plugin-server
## 构建插件服务器镜像并推送
```bash
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  -t {your-image-storage}/higress-plugin-server:1.0.0 \
  -f Dockerfile \
  --push \
  .
```
## 在 higress-console 中配置插件下载地址
要满足这一需求，只需要为 Higress Console 容器添加 HIGRESS_ADMIN_WASM_PLUGIN_CUSTOM_IMAGE_URL_PATTERN 环境变量，值为自定义镜像地址的格式模版。模版可以按需使用 ${name} 和 ${version} 作为插件名称和镜像版本的占位符。
在进行了以下配置后，
```bash
HIGRESS_ADMIN_WASM_PLUGIN_CUSTOM_IMAGE_URL_PATTERN=http://higress-plugin-server.higress-system.svc/plugins/${name}/${version}/plugin.wasm
```
Higress Console 针对 key-rate-limit 插件生成的镜像地址将为：http://higress-plugin-server.higress-system.svc/plugins/key-rate-limit/1.0.0/plugin.wasm
