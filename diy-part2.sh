#!/bin/bash
#=============================================================
# diy-360t7.sh — 360T7 (MT7981) DIY 脚本
#=============================================================
set -euo pipefail

log() { echo ">>> [360T7] $*"; }

# ============================================================
# 基础设置（IP）+ 名称
# ============================================================
log "设置默认 IP → 192.168.124.1"
sed -i 's/192.168.1.1/192.168.124.1/g' ./package/base-files/files/bin/config_generate
sed -i 's/hostname="ImmortalWrt"/hostname="360T7"/g' ./package/base-files/files/bin/config_generate

# ============================================================
# Golang + lang rust（部分插件编译依赖）
# ============================================================
# log "替换 Golang → 27.x"
# rm -rf feeds/packages/lang/golang
# git clone --depth=1 -b 27.x https://github.com/sbwml/packages_lang_golang feeds/packages/lang/golang

# log "修复 lang-rust 404 问题"
# rm -rf feeds/packages/lang/rust
# git clone --depth=1 https://github.com/sbwml/packages_lang_rust feeds/packages/lang/rust

# ============================================================
# 克隆官方 Passwall + 依赖
# ============================================================
log "克隆官方 Passwall"
# 移除 openwrt feeds 自带的核心库
rm -rf feeds/packages/net/{xray-core,v2ray-geodata,sing-box,chinadns-ng,dns2socks,hysteria,ipt2socks,microsocks,naiveproxy,shadowsocks-rust,shadowsocksr-libev,simple-obfs,tcping,v2ray-plugin,xray-plugin,geoview,shadow-tls}
# git clone https://github.com/Openwrt-Passwall/openwrt-passwall-packages package/passwall-packages

# 移除 openwrt feeds 过时的luci版本
rm -rf feeds/luci/applications/luci-app-passwall
# git clone https://github.com/Openwrt-Passwall/openwrt-passwall package/passwall-luci

git clone --depth=1 https://github.com/Openwrt-Passwall/openwrt-passwall-packages.git package/passwall-packages
git clone --depth=1 https://github.com/Openwrt-Passwall/openwrt-passwall.git package/passwall

# ============================================================
# 克隆第三方插件
# ============================================================

# --- nikki ---
log "克隆 nikki"
git clone --depth=1 https://github.com/nikkinikki-org/OpenWrt-nikki package/nikki

# --- lucky ---
log "克隆 lucky"
git clone --depth=1 https://github.com/gdy666/luci-app-lucky package/lucky

# --- bandix ---
log "克隆 bandix"
git clone --depth=1 https://github.com/timsaya/luci-app-bandix package/bandix
git clone --depth=1 https://github.com/timsaya/openwrt-bandix package/openwrt-bandix
# ============================================================

log "完成 ✓"
