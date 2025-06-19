#!/usr/bin/env bash
set -e                                  # 任何步骤出错即退出
RED='\E[1;31m'; RST='\E[0m'

echo -e "${RED}=== env check ===${RST}"
if [ ! -f boot.img ]; then
  echo "create 1.44 MB FAT12..."
  dd if=/dev/zero of=boot.img bs=512 count=2880
  mkfs.fat -F 12 boot.img      # 写入标准 BPB+ FAT 表
fi

echo -e "${RED}=== build bootloader ===${RST}"
make -C bootloader
echo -e "${RED}=== build kernel ===${RST}"
make -C kernel

echo -e "${RED}=== write boot.bin => boot.img ===${RST}"
# 只覆盖 62 B 以后（不破坏 BPB）
dd if=bootloader/boot.bin  of=boot.img bs=1 skip=62 seek=62  conv=notrunc
dd if=bootloader/boot.bin  of=boot.img bs=1 skip=510 seek=510 count=2 conv=notrunc

echo -e "${RED}=== copy files (mount) ===${RST}"
mkdir -p tmp
sudo mount -o loop -t vfat boot.img tmp
sudo rm -f tmp/*                              # 清空旧文件
sudo cp bootloader/loader.bin tmp/
sudo cp kernel/kernel.bin     tmp/
sync
sudo umount tmp
rmdir tmp

echo -e "${RED}=== run Bochs (press c) ===${RST}"
bochs -qf .bochsrc
