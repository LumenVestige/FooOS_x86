# 工具链前缀
CROSS = x86_64-linux-gnu-

# 编译器、汇编器、链接器
CC = $(CROSS)gcc
LD = $(CROSS)ld
AS = $(CROSS)as
OBJCOPY = $(CROSS)objcopy

# 编译选项
CFLAGS = -static -fno-builtin -fno-stack-protector -nostdlib
ASFLAGS =
LDFLAGS = -z muldefs -T Kernel.lds

# 默认目标
all: system
	$(OBJCOPY) -I elf64-x86-64 -S -R ".eh_frame" -R ".comment" -O binary system kernel.bin

# 链接
system: head.o main.o printk.o
	$(LD) -b elf64-x86-64 $(LDFLAGS) -o $@ $^

# 汇编
head.o: head.S
	$(CC) -E $< -o head.s
	$(AS) -o $@ head.s

# C 文件
main.o: main.c lib.h
	$(CC) $(CFLAGS) -c $< -o $@

printk.o: printk.c lib.h
	$(CC) $(CFLAGS) -c $< -o $@

# 清理
clean:
	rm -rf *.o *.s *.s~ *.S~ *.c~ *.h~ system Makefile~ Kernel.lds~ kernel.bin
