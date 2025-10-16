# 重新编译H5前端的步骤

## 问题原因
您修改的是uni-app的源码文件（`.vue`文件），但H5访问的是编译后的文件。需要重新编译才能看到更改。

## 最简单的解决方案：使用HBuilderX

### 步骤1：下载安装HBuilderX
- 下载地址：https://www.dcloud.io/hbuilderx.html
- 下载"标准版"即可（不需要App开发版）

### 步骤2：打开项目
1. 启动HBuilderX
2. 文件 > 打开目录
3. 选择：`D:\wwei\NSS-WEB\src\main\resources\front\front`

### 步骤3：编译H5
1. 在HBuilderX中，点击顶部菜单：**发行** > **网站-H5手机版**
2. 等待编译完成（会在控制台显示进度）
3. 编译成功后，文件会生成在 `unpackage/dist/build/h5/` 目录

### 步骤4：部署编译文件

**方法一：使用自动化脚本（推荐）**
1. 双击运行根目录下的 `deploy_h5_after_build.ps1` 脚本
2. 脚本会自动完成所有部署步骤，包括：
   - 检查编译文件是否存在
   - 备份现有H5文件
   - 部署新编译的H5文件到resources目录
   - 同步到target/classes目录
3. 等待脚本执行完成

**方法二：手动执行命令**
如果脚本无法运行，可以打开PowerShell，执行以下命令：

```powershell
cd D:\wwei\NSS-WEB

# 备份现有H5文件（可选）
Rename-Item -Path "src\main\resources\front\front\h5" -NewName "h5_backup_$(Get-Date -Format 'yyyyMMdd_HHmmss')"

# 复制新编译的H5文件
Copy-Item -Path "src\main\resources\front\front\unpackage\dist\build\h5" -Destination "src\main\resources\front\front\h5" -Recurse

# 同时更新target/classes目录（Spring Boot从这里读取）
Remove-Item -Path "target\classes\front\front\h5" -Recurse -Force -ErrorAction SilentlyContinue
Copy-Item -Path "src\main\resources\front\front\h5" -Destination "target\classes\front\front\h5" -Recurse
```

### 步骤5：重启应用
重新运行 `SpringbootSchemaApplication.java`

然后访问：http://localhost:8080/springbootsme07/front/h5/index.html#/pages/index/index

---

## 已完成的修改内容

✅ **源码修改完成** - `src/main/resources/front/front/pages/index/index.vue`

### 新增功能：
1. **知识讲解视频模块**
   - 位置：科普知识推荐模块下方
   - 数据来源：从 `kepuzhishi` 表获取有视频的科普知识
   - 显示数量：最多5条，按时间倒序
   - 功能特性：
     - ✅ 视频播放器（支持播放控制）
     - ✅ 显示封面图作为视频封面
     - ✅ 显示标题、分类、浏览次数
     - ✅ 点击可跳转到详情页

### 技术实现：
```javascript
// 获取有视频的科普知识
res = await this.$api.list('kepuzhishi', {
    page: 1,
    limit: 20,  // 获取更多数据以确保有足够的视频内容
    sort: 'addtime',
    order: 'desc'
});
// 过滤出有视频的数据，最多显示5条
this.videoList = res.data.list.filter(item => item.kepushipin && item.kepushipin != '').slice(0, 5);
```

---

## 常见问题

### Q: 为什么直接运行Spring Boot看不到更改？
A: uni-app是编译型框架，修改源码后需要重新编译成H5才能看到效果。

### Q: 可以不用HBuilderX吗？
A: 可以，但需要安装Node.js和@dcloudio/vite-plugin-uni等依赖，配置较复杂。HBuilderX是最简单的方式。

### Q: 编译需要多久？
A: 通常30秒到2分钟，取决于您的电脑性能。

### Q: Web管理后台需要重新编译吗？
A: 不需要，Web管理后台（admin）没有修改，不受影响。

### Q: 为什么推荐使用自动化脚本？
A: 自动化脚本提供了更好的用户体验：
- ✅ 自动检查编译文件是否存在
- ✅ 彩色输出，清晰显示执行进度
- ✅ 完善的错误处理和提示
- ✅ 一键完成所有部署步骤
- ✅ 避免手动输入命令的错误

