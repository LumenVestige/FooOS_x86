# bootloader/CMakeLists.txt
set(ASM_INC ${CMAKE_CURRENT_SOURCE_DIR})  # 头文件就在同级目录

add_custom_command(
        OUTPUT boot.bin
        COMMAND nasm -I${ASM_INC}/
        ${CMAKE_CURRENT_SOURCE_DIR}/boot.asm
        -o ${CMAKE_CURRENT_BINARY_DIR}/boot.bin
        DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/boot.asm
        COMMENT "Assembling boot.asm -> boot.bin"
)

add_custom_command(
        OUTPUT loader.bin
        COMMAND nasm -I${ASM_INC}/
        ${CMAKE_CURRENT_SOURCE_DIR}/loader.asm
        -o ${CMAKE_CURRENT_BINARY_DIR}/loader.bin
        DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/loader.asm
        ${CMAKE_CURRENT_SOURCE_DIR}/fat12.inc
        COMMENT "Assembling loader.asm -> loader.bin"
)

add_custom_target(bootloader ALL
        DEPENDS boot.bin)
