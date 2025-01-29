
## helpers
function title {
  echo
  echo "################################################################################"
  echo "## $1"
  echo "################################################################################"
  echo
}

echo '✨ STARTING...'
container_name=pulao
deploy_dir=$HOME/deploys/pulao
version=$(cat $deploy_dir/version)

title '⏳ APP: Docker build ...'
docker build $deploy_dir -t $container_name:$version

title '⏳ APP: Checking container ...'
if [ ! -z "$(docker ps -aq -f name=^$container_name$)" ]; then
  echo '⏳ 🔴 APP: 删除正在运行的老容器'
  docker rm -f $container_name
fi

title '⏳ APP: Docker run ...'
docker run -d -p 8888:3000 \
            --name=$container_name \
            -e RAILS_MASTER_KEY=$RAILS_MASTER_KEY \
            -e DATABASE_URL=$DATABASE_URL \
            $container_name:$version

title '⏳ 🟠 执行更新数据库...'
docker exec $container_name bin/rails db:create db:migrate 

echo '🎉 START!'