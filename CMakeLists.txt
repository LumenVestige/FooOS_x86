cmake_minimum_required(VERSION 3.13)
project(FooOs LANGUAGES C ASM)

#
## --------------------------------------------------
## 子目录
## --------------------------------------------------
#add_subdirectory(bootloader)
#add_subdirectory(kernel)
#
## 输出路径变量
#set(BOOT_IMG     ${CMAKE_BINARY_DIR}/boot.img)
#set(BOOT_BIN     ${CMAKE_BINARY_DIR}/bootloader/boot.bin)
#set(LOADER_BIN   ${CMAKE_BINARY_DIR}/bootloader/loader.bin)
#set(KERNEL_BIN   ${CMAKE_BINARY_DIR}/kernel/kernel.bin)
#set(MOUNT_DIR    ${CMAKE_BINARY_DIR}/tmp)
## 运行目标（依赖构建后文件）
#add_custom_target(boot.img
#        DEPENDS bootloader kernel
#
#        COMMAND dd if=/dev/zero of=${BOOT_IMG}  bs=512 count=2880
#        COMMAND mkfs.vfat -F 12 ${BOOT_IMG}
#
#        COMMAND dd if=${BOOT_BIN} of=${BOOT_IMG} bs=512 count=1 conv=notrunc
#        COMMAND mcopy -i ${BOOT_IMG} -o -v ${LOADER_BIN} ::loader.bin
#        COMMAND mcopy -i ${BOOT_IMG} -o -v ${KERNEL_BIN} ::kernel.bin
#        COMMAND cp ${BOOT_IMG} ./out/boot.img
#
#)