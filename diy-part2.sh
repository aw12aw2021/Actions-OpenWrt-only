# 文件名: diy-part2.sh
# 描述: OpenWrt DIY script part 2 (放在安装feeds之后)

# 修改管理IP
#sed -i 's/192.168.1.1/192.168.1.2/g' package/base-files/files/bin/config_generate

# 强制切换内核版本
sed -i "s/KERNEL_PATCHVER:=*.*/KERNEL_PATCHVER:=5.19/g" target/linux/x86/Makefile
sed -i "s/KERNEL_TESTING_PATCHVER:=*.*/KERNEL_TESTING_PATCHVER:=5.19/g" target/linux/x86/Makefile

# 修改默认皮肤
sed -i 's/luci-theme-bootstrap/luci-theme-argon-mod/g' feeds/luci/collections/luci/Makefile
sed -i 's/luci-theme-bootstrap/luci-theme-argon-mod/g' feeds/luci/collections/luci-nginx/Makefile
sed -i 's/luci-theme-bootstrap/luci-theme-argon-mod/g' feeds/luci/collections/luci-ssl-nginx/Makefile

# 修改主机名以及一些显示信息
sed -i "s/hostname='*.*'/hostname='OpenWrt'/" package/base-files/files/bin/config_generate
sed -i "s/DISTRIB_ID='*.*'/DISTRIB_ID='OpenWrt'/g" package/base-files/files/etc/openwrt_release
sed -i "s/DISTRIB_DESCRIPTION='*.*'/DISTRIB_DESCRIPTION='OpenWrt'/g"  package/base-files/files/etc/openwrt_release
sed -i '/(<%=pcdata(ver.luciversion)%>)/a\      built by ywt114' package/lean/autocore/files/x86/index.htm
echo "$(date +'%m.%d.%Y')" > package/base-files/files/etc/openwrt_version

# 修改登录密码
sed -i 's/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.:0:0:99999:7:::/root::0:0:99999:7:::/g' package/lean/default-settings/files/zzz-default-settings

# 开启wifi选项
sed -i 's/disabled=1/disabled=0/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# 添加关机按钮到系统选项
curl -fsSL  https://raw.githubusercontent.com/ywt114/poweroff/main/poweroff.htm > feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_system/poweroff.htm
curl -fsSL  https://raw.githubusercontent.com/ywt114/poweroff/main/system.lua > feeds/luci/modules/luci-mod-admin-full/luasrc/controller/admin/system.lua

# 删除默认源插件
#rm -rf feeds/luci/applications/luci-app-netdata/

# 添加插件
cd package/lean
git clone https://github.com/ywt114/luci-app-advanced
git clone https://github.com/sbwml/luci-app-alist
git clone https://github.com/xiangfeidexiaohuo/openwrt-packages
mv openwrt-packages/luci-app-eqos/ ./
mv openwrt-packages/op-homebox/ ./
mv openwrt-packages/op-socat/ ./
rm -rf openwrt-packages/
git clone https://github.com/linkease/istore
sed -i 's/+luci-lib-ipkg/+luci-base/g' istore/luci/luci-app-store/Makefile
