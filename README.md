# higress-plugin-server
## 拉取插件
确认机器已经安装 oras 工具，运行
```bash
# 从 oci 仓库拉取插件并生成元数据
python pull_plugins.py ./plugins.properties
```
## 手工添加插件后生成元数据
```bash
python generate_metadata.py
```
## 构建插件服务器镜像并推送
```bash
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  -t {your-image-storage}/higress-plugin-server:1.0.0 \
  -f Dockerfile \
  --push \
  .
```
## 在 higress-console 中按照以下格式配置插件下载地址
```bash
http://higress-plugin-server.higress-system.svc/plugins/key-auth/1.0.0/plugin.wasm
```
