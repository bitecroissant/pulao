
## helpers
function title {
  echo
  echo "################################################################################"
  echo "## $1"
  echo "################################################################################"
  echo
}

time=$(date +'%Y%m%d-%H%M%S')

dist=tmp/pulao-$time.tar.gz
current_dir=$(dirname $0)
deploy_dir=$HOME/deploys/pulao
gemfile=$current_dir/../Gemfile
gemfile_lock=$current_dir/../Gemfile.lock
vendor_cache_dir=$current_dir/../vendor/cache

echo '✨ PACKING...'

title '📦 打包源代码为压缩文件'
bundle cache
tar --exclude="tmp/cache/*" --exclude="vendor/*" -czv -f $dist *

title '📮 创建目录'
mkdir -p $deploy_dir/vendor

title '📤 传送压缩文件'
mv $dist $deploy_dir
cp $gemfile $deploy_dir
cp $gemfile_lock $deploy_dir

title '📤 传送vendor/cache'
cp -r $vendor_cache_dir $deploy_dir/vendor

title '📤 传送 Dockerfile'
cp $current_dir/../config/local.Dockerfile $deploy_dir/Dockerfile

title '📤 传送 starter(setup) 脚本'
cp $current_dir/starter_for_local.sh $deploy_dir/

title '📤 传送版本号码'
echo $time > $deploy_dir/version

title '🫧` 启动！'
$deploy_dir/starter_for_local.sh

echo '🎉 ALL DONE!'