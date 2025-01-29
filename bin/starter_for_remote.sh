#!/bin/bash

## helpers
function title {
  echo
  echo "################################################################################"
  echo "## $1"
  echo "################################################################################"
  echo
}

function set_env {
  name=$1
  hint=$2
  [[ ! -z "${!name}" ]] && return
  while [ -z "${!name}" ]; do
    [[ ! -z "$hint" ]] && echo "🤖 > 请输入 $name: $hint" || echo "🤖 > 请输入 $name"
    read $name
  done
  sed -i "1s/^/export $name=${!name}\n/" ~/.bashrc
}

user=pulaocore
root=/home/$user/deploys/$version
container_name=pulaocore-container
db_container_name=pulaocore-pgproxy

echo '✨ STARTING...'

title '📟 设置远程机器环境变量'
set_env DB_HOST
set_env DB_PASSWORD
set_env RAILS_MASTER_KEY '🪅 请将 config/credentials/production.key 的内容复制到这里'

title '🚥 Checking database ...'
if [ ! -z "$(docker ps -aq -f name=^$DB_HOST$)" ]; then
  echo '🚥 数据库状态自检完成'
else
  title '⏳ 创建数据库'
  docker run -d --name $DB_HOST \
            --network=network1 \
            -e POSTGRES_USER=bitecroissant \
            -e POSTGRES_DB=pulao_prod \
            -e POSTGRES_PASSWORD=$DB_PASSWORD \
            -e PGDATA=/var/lib/postgresql/data/pgdata \
            -v pulao-data:/var/lib/postgresql/data \
            -p 5432:5432 \
            postgres:14
  title '🟢 创建数据库成功'
fi

title '⏳ APP: Docker build ...'
docker build $root -t $container_name:$version

title '⏳ APP: Checking container ...'
if [ ! -z "$(docker ps -aq -f name=^$container_name$)" ]; then
  echo '⏳ 🔴 APP: 删除正在运行的老容器'
  docker rm -f $container_name
fi
title '⏳ APP: Docker run ...'
docker run -d -p 3000:3000 \
            --name=$container_name \
            --network=network1 \
            -e RAILS_MASTER_KEY=$RAILS_MASTER_KEY \
            -e DB_HOST=$DB_HOST \
            -e DB_PASSWORD=$DB_PASSWORD \
            $container_name:$version

if [ ! -z "$need_migrate" ]; then
  title '⏳ 🟠 执行更新数据库...'
  docker exec $container_name bin/rails db:create db:migrate 
fi

echo '🎉 DONE!'