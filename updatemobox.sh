#!/bin/bash

apt update -y
apt install -y glibc-repo
apt install -y mangohud-glibc
apt install -y libxcb*
apt install -y xorgproto*
apt install -y unzip

if [ ! -e backups ]; then
        mkdir backups
        cp $PREFIX/etc/bash.bashrc ~/backups
        cp $PREFIX/glibc/opt/libs/d3d/vkd3d.7z ~/backups
        cp $PREFIX/glibc/opt/libs/mesa/turnip-v6.5.7z ~/backups
        cp $PREFIX/glibc/opt/libs/d3d/dxvk-dev.7z ~/backups
        cp $PREFIX/glibc/bin/box64 ~/backups
        mv $PREFIX/glibc/wine-9.3-vanilla-wow64 ~/backups/wine-9.3-vanilla-wow64
fi

echo "export MANGOHUD=1" >> $PREFIX/etc/bash.bashrc
echo "export MANGOHUD_CONFIG=engine_version,ram,vulkan_driver" >> $PREFIX/etc/bash.bashrc
echo "export BOX64_IGNOREINT3=0" >> $PREFIX/etc/bash.bashrc
echo "export BOX64_FUTEX_WAITV=1" >> $PREFIX/etc/bash.bashrc
echo "export BOX64_DYNAREC_DIV0=0" >> $PREFIX/etc/bash.bashrc
echo "export BOX64_CEFDISABLEGPUCOMPOSITOR=1" >> $PREFIX/etc/bash.bashrc
echo "export BOX64_CEFDISABLEGPU=1" >> $PREFIX/etc/bash.bashrc
echo "export BOX64_MALLOC_HACK=0" >> $PREFIX/etc/bash.bashrc
echo "export BOX64_RESERVE_HIGH=0" >> $PREFIX/etc/bash.bashrc
echo "export BOX64_SSE_FLUSHTO0=" >> $PREFIX/etc/bash.bashrc
echo "export BOX64_SYNC_ROUNDING=1" >> $PREFIX/etc/bash.bashrc
echo "export BOX64_DYNAREC_WAIT=0" >> $PREFIX/etc/bash.bashrc
echo "export BOX64_X87_NO80BITS=0" >> $PREFIX/etc/bash.bashrc
if [ $(su -c id -u) = 0 ]; then 
        echo "su -c setenforce 0 &>/dev/null" >> $PREFIX/etc/termux-login.sh
        echo "su -c ulimit -c unlimited &>/dev/null" >> $PREFIX/etc/termux-login.sh
fi
echo "export VK_DRIVER_FILES=\"\$VK_ICD_FILENAMES\"" >> $PREFIX/glibc/opt/default-conf/conf/path.conf


wget https://github.com/GabiAle97/mobox-updater/releases/download/mesa/vkd3d.zip -O vkd3d.zip
unzip vkd3d.zip
mv x64 system32
mv x86 syswow64
7z a vkd3d.7z sys*
cp vkd3d.7z $PREFIX/glibc/opt/libs/d3d/vkd3d.7z

https://github.com/khisy/Moboxmod/releases/download/Moboxmod/turnip.tar.xz
tar xf turnip.tar.xz
7z a turnip-5.7z libvulkan_freedreno.so
mv turnip-5.7z $PREFIX/glibc/opt/libs/mesa/turnip-v5.7z
rm -rf libvulkan_freedreno.so turnip.tar.xz

wget https://github.com/doitsujin/dxvk/releases/download/v2.4/dxvk-2.4.tar.gz -O dxvk-0.96.tar.gz
tar xf dxvk-0.96.tar.gz
cd dxvk-2.4
mv x64 system32
mv x32 syswow64
7z a dxvk-0.96.7z sys*
cp dxvk-0.96.7z $PREFIX/glibc/opt/libs/d3d/dxvk-0.96.7z

wget https://github.com/khisy/Moboxmod/releases/download/Moboxmod/box64.tar.xz
tar -xvf box64.tar.xz -C $PREFIX/glibc/bin/
rm -rf box64.tar.xz

wget https://github.com/khisy/Moboxmod/releases/download/Moboxmod/wine.tar.xz
mkdir wine
tar xf wine.tar.xz -C wine
mv wine/* wine/wine-9.3-vanilla-wow64
mv wine/wine-9.3-vanilla-wow64 $PREFIX/glibc/wine-9.3-vanilla-wow64
rm -rf wine*

cd
rm -rf vkd3d.tar.zst vkd3d-proton-2.12

function undo_updater_changes(){
        cd ~/backups
        cp ~/backups/bash.bashrc $PREFIX/etc/bash.bashrc
        cp ~/backups/vkd3d.7z $PREFIX/glibc/opt/libs/d3d/vkd3d.7z
        cp ~/backups/turnip-v5.7z $PREFIX/glibc/opt/libs/mesa/turnip-v5.7z
        cp ~/backups/dxvk-0.96.7z $PREFIX/glibc/opt/libs/d3d/dxvk-0.96.7z
        cp ~/backups/box64 $PREFIX/glibc/bin/box64
        rm -rf $PREFIX/glibc/wine-9.3-vanilla-wow64
        mv ~/backups/wine-9.3-vanilla-wow64 $PREFIX/glibc/wine-9.3-vanilla-wow64
        

}

