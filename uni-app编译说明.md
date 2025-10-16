# Uni-App H5 编译说明

## 问题说明
修改了 `src/main/resources/front/front/pages/index/index.vue` 源码后，H5页面没有变化。

这是因为uni-app项目需要重新编译才能生效。

## 解决方案

### 方案一：使用 HBuilderX（推荐）

1. 下载并安装 HBuilderX：https://www.dcloud.io/hbuilderx.html
2. 用 HBuilderX 打开项目目录：`src/main/resources/front/front`
3. 点击菜单：**发行 > H5-手机版**
4. 编译完成后，编译结果会输出到 `unpackage/dist/build/h5/` 目录
5. 将编译结果复制到 `h5/` 目录：
   ```powershell
   # 删除旧的H5文件
   Remove-Item -Path "src/main/resources/front/front/h5/*" -Recurse -Force
   
   # 复制新编译的文件
   Copy-Item -Path "src/main/resources/front/front/unpackage/dist/build/h5/*" -Destination "src/main/resources/front/front/h5/" -Recurse
   ```
6. 重启Spring Boot应用即可看到更改

### 方案二：使用 Vue CLI（需要安装依赖）

如果您的项目支持使用@dcloudio/vite-plugin-uni或@dcloudio/webpack-uni-mp-loader，可以使用命令行编译：

1. 在 `src/main/resources/front/front` 目录下安装依赖（如果没有package.json，则不适用此方案）
2. 运行编译命令
3. 将编译结果复制到h5目录

## 当前项目状态

✅ 源码已修改完成：`src/main/resources/front/front/pages/index/index.vue`
❌ H5需要重新编译才能看到更改

## 修改内容
已在首页添加"知识讲解视频"模块：
- 位置：科普知识推荐下方
- 数据来源：kepuzhishi表（自动过滤有视频的记录）
- 功能：视频播放、标题显示、分类和浏览次数展示

