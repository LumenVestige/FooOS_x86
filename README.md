# Is Updating...

# fooOs
A simple test foo OS

## 环境安装
+ 执行 sh ./[docker_img_build.sh](docker_img_build_mac.sh) 构建docker镜像
+ 执行 sh ./[docker_container_run_once.sh](docker_container_run_once_mac.sh) 启动docker容器（包含bochs虚拟机以及交叉编译链环境）

## 编译
+ CMake Project Reload:右击[CMakeLists.txt](CMakeLists.txt),点击Reload CMake Project:  
 <img src="source/cmake_project_reload.png" alt="cmake_project_reload" style="width:30%;"/>

+ 配置编译链环境：  
<img src="source/toolchain.png" alt="toolchain" style="width:50%;"/>

+ 配置Cmake环境：  
<img src="source/cmake.png" alt="cmake" style="width:50%;"/>

+ 编译boot.img镜像:  
<img src="source/build.png" alt="cmake" style="width:30%;"/>

+ 加载boot.img测试（需要先确保已经执行了[docker_container_run_once.sh](docker_container_run_once_mac.sh)，当前环境在docker容器中）:
```
  sh ./run.sh
```

## 文档
+ 参考源码：
  + https://github.com/yourtion/30dayMakeOS
  + https://github.com/yourtion/YOS
+ 笔记：[notes](notes)
