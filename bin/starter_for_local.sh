echo '✨ STARTING...'
container_name=pulao

version=$(cat pulao_deploy/version)

echo $version
echo 'Docker destroying... '
docker rm -f pulao
echo 'Docker building ...'
docker build pulao_deploy -t pulao:$version
echo 'Docker run ...'
docker run -d -p 8888:3000 -e RAILS_MASTER_KEY=$RAILS_MASTER_KEY -e DATABASE_URL=$DATABASE_URL --name=$container_name pulao:$version
echo 'Docker exec ...'
docker exec -e -it $container_name bin/rails db:create db:migrate
echo '🎉 DONE!'