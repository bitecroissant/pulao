#!/bin/bash

# helper
function title {
  echo
  echo "################################################################################"
  echo "## $1"
  echo "################################################################################"
  echo
}

user=pulaocore
ip=47.116.30.230

time=$(date +'%Y%m%d-%H%M%S')
cache_dir=tmp/deploy_cache
dist=$cache_dir/pulao-$time.tar.gz
current_dir=$(dirname $0)
deploy_dir=/home/$user/deploys/$time
gemfile=$current_dir/../Gemfile
gemfile_lock=$current_dir/../Gemfile.lock

echo '✨ PACKING...'

mkdir -p $cache_dir
title '📦 打包源代码为压缩文件'
tar --exclude="tmp/cache/*" -czv -f $dist *

title '📮 创建远程目录'
ssh $user@$ip "mkdir -p $deploy_dir"

title '📤 上传压缩文件'
scp $dist $user@$ip:$deploy_dir/
scp $gemfile $user@$ip:$deploy_dir/
scp $gemfile_lock $user@$ip:$deploy_dir/

title '📤 上传 Dockfile'
scp $current_dir/../config/remote.Dockerfile $user@$ip:$deploy_dir/Dockerfile

title '📤 上传 starter(setup) 脚本'
scp $current_dir/starter_for_remote.sh $user@$ip:$deploy_dir/

title '📤 上传版本号码'
ssh $user@$ip "echo $time > $deploy_dir/version"

title '🫧` 执行远程脚本'
ssh $user@$ip "export version=$time; /bin/bash $deploy_dir/starter_for_remote.sh"

echo '🎉 DONE!'