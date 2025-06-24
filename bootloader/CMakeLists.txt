cmake_minimum_required(VERSION 3.10)
project(BootLoader ASM)

# 设置汇编器（使用 nasm）
enable_language(ASM_NASM)

# 设置输出文件名
set(BOOT_BIN ${CMAKE_BINARY_DIR}/boot.bin)

# 设置源文件
set(SRC ${CMAKE_CURRENT_SOURCE_DIR}/boot.S)
message(STATUS "SRC = ${SRC}")
# 添加自定义构建命令，调用 nasm 生成 boot.bin
add_custom_command(
        OUTPUT ${BOOT_BIN}
        COMMAND nasm -f bin ${SRC} -o ${BOOT_BIN}
        DEPENDS ${SRC}
        COMMENT "Assembling boot.asm to boot.bin..."
        VERBATIM
)

# 添加一个伪目标 boot，依赖 boot.bin
add_custom_target(bootloader ALL
        DEPENDS ${BOOT_BIN}
)
