# 文件名: diy-part1.sh
# 描述: OpenWrt DIY script part 1 (放在更新feeds之前)

# 修改feeds源
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# 添加feeds源
echo 'src-git helloworld https://github.com/fw876/helloworld.git' >> feeds.conf.default
echo 'src-git passwall_packages https://github.com/xiaorouji/openwrt-passwall.git;packages' >> feeds.conf.default
echo 'src-git passwall_luci https://github.com/xiaorouji/openwrt-passwall.git;luci' >> feeds.conf.default
echo 'src-git OpenClash https://github.com/vernesong/OpenClash.git' >> feeds.conf.default
