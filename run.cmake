cmake_minimum_required(VERSION 3.10)

message(STATUS "=== env check ===")

if(NOT EXISTS "${CMAKE_SOURCE_DIR}/boot.img")
    message(STATUS "No boot.img, generating...")
    execute_process(COMMAND bash -c "echo -e '1\nfd\n\nboot.img\n' | bximage"
            WORKING_DIRECTORY ${CMAKE_SOURCE_DIR})
else()
    message(STATUS "Found boot.img")
endif()

message(STATUS "=== write boot.bin to boot.img ===")
execute_process(COMMAND dd if=bootloader/loader.bin of=boot.img bs=512 count=1 conv=notrunc)

file(MAKE_DIRECTORY tmp)
execute_process(COMMAND sudo mount -t vfat -o loop boot.img tmp)

execute_process(COMMAND sudo cp bootloader/loader.bin tmp)
execute_process(COMMAND sudo cp kernel/kernel.bin tmp)
execute_process(COMMAND sync)
execute_process(COMMAND sudo umount tmp)
file(REMOVE_RECURSE tmp)

message(STATUS "=== running bochs ===")
#execute_process(COMMAND cp ../.bochsrc .bochsrc)
execute_process(COMMAND bochs -qf  .bochsrc)
