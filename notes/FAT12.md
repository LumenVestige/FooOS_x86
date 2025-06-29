# FAT12 文件系统结构简介

**FAT12** 是一种早期的文件系统格式，广泛用于软盘、引导盘和小容量存储设备中。其名称中的 “12” 表示使用 **12 位簇号** 来标识数据块。

---

## 📂 文件系统结构


---

## 🔍 区域说明

| 区域名称     | 说明 |
|--------------|------|
| Boot Sector  | 包含跳转指令、OEM 标识、BIOS 参数块、引导代码等 |
| FAT 表       | 文件分配表，记录每个簇的使用状态（空闲、占用、结束） |
| 根目录区     | 存储根目录下的文件和目录信息（最多 224 个条目） |
| 数据区       | 实际存储文件内容的区域 |

---

## ⚙️ 常见参数配置

| 参数           | 示例值         |
|----------------|----------------|
| 每扇区字节数   | 512 bytes      |
| 每簇扇区数     | 1              |
| FAT 表数量     | 2              |
| 保留扇区数     | 1              |
| 根目录条目数   | 224（14 KB）   |
| 支持最大容量   | 约 32 MB（理论） |

---

## 🛠️ 实用命令

### 创建 FAT12 镜像
```bash
dd if=/dev/zero of=boot.img bs=512 count=2880  # 创建 1.44MB 镜像
mkfs.fat -F 12 boot.img                        # 格式化为 FAT12
