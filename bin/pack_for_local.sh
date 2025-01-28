echo '✨ PACKING...'
dir=pulao
time=$(date +'%Y%m%d-%H%M%S')

dist=tmp/pulao-$time.tar.gz
current_dir=$(dirname $0)
deploy_dir=$HOME/workspace/$dir/pulao_deploy

yes | rm tmp/pulao-*.tar.gz;
yes | rm $deploy_dir/pulao-*.tar.gz;

# sync
tar --exclude="tmp/cache/*" -czv -f $dist *
mkdir -p $deploy_dir
cp $current_dir/../config/local.Dockerfile $deploy_dir/Dockerfile
cp $current_dir/starter_for_local.sh $deploy_dir/
mv $dist $deploy_dir
echo $time > $deploy_dir/version
echo '🎉 DONE!'