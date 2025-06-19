# ============================================================
# kernel/CMakeLists.txt  ——  构建 x86_64 裸机内核 (kernel.bin)
# ============================================================

cmake_minimum_required(VERSION 3.13)
project(kernel NONE)                # 不需要 C/C++ 标准工程特性

# 交叉编译器前缀
set(CROSS x86_64-linux-gnu-)

# 工具链
set(CMAKE_C_COMPILER ${CROSS}gcc)
set(AS                ${CROSS}gcc)      # 用 gcc 汇编（便于预处理）
set(LD                ${CROSS}ld)
set(OBJCOPY           ${CROSS}objcopy)

# 编译 / 链接选项
set(CFLAGS
        -static
        -fno-builtin
        -fno-stack-protector
        -nostdlib
)
set(LDFLAGS -z muldefs
        -T ${CMAKE_CURRENT_SOURCE_DIR}/Kernel.lds)
set(OBJCOPY_FLAGS -I elf64-x86-64
        -S
        -R .eh_frame
        -R .comment
        -O binary)

#--------------------------------------------------------------
# 1. 生成 head.o  （一步完成：预处理 + 汇编）
#--------------------------------------------------------------
add_custom_command(
        OUTPUT head.o
        COMMAND ${AS} -c -x assembler-with-cpp ${CMAKE_CURRENT_SOURCE_DIR}/head.S -o head.o
        DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/head.S
        COMMENT "Assembling head.S → head.o"
)

#--------------------------------------------------------------
# 2. 编译 main.c 和 printk.c  →  main.o  printk.o
#--------------------------------------------------------------
foreach(src main.c printk.c)
    get_filename_component(obj ${src} NAME_WE)
    add_custom_command(
            OUTPUT ${obj}.o
            COMMAND ${CMAKE_C_COMPILER} ${CFLAGS} -c ${CMAKE_CURRENT_SOURCE_DIR}/${src} -o ${obj}.o
            DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/${src} ${CMAKE_CURRENT_SOURCE_DIR}/lib.h
            COMMENT "Compiling ${src} → ${obj}.o"
    )
    list(APPEND OBJ_FILES ${obj}.o)
endforeach()

#--------------------------------------------------------------
# 3. 链接所有 .o 生成 system
#--------------------------------------------------------------
add_custom_command(
        OUTPUT system
        COMMAND ${LD} ${LDFLAGS} -o system head.o ${OBJ_FILES}
        DEPENDS head.o ${OBJ_FILES} ${CMAKE_CURRENT_SOURCE_DIR}/Kernel.lds
        COMMENT "Linking → system"
)

#--------------------------------------------------------------
# 4. objcopy 生成最终 kernel.bin
#--------------------------------------------------------------
add_custom_command(
        OUTPUT kernel.bin
        COMMAND ${OBJCOPY} ${OBJCOPY_FLAGS} system kernel.bin
        DEPENDS system
        COMMENT "Objcopy → kernel.bin"
)

#--------------------------------------------------------------
# 5. 顶层目标：执行 `cmake --build` 就得到 kernel.bin
#--------------------------------------------------------------
add_custom_target(kernel ALL DEPENDS kernel.bin)

# 可选：安装或复制 kernel.bin 到上级目录
# install(FILES ${CMAKE_CURRENT_BINARY_DIR}/kernel.bin DESTINATION ${CMAKE_SOURCE_DIR})
