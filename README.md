# 蒲牢项目 README

## `Rails` 的密钥管理

```
rm config/master.key config/credentials.yml.enc 

EDITOR="code --wait" bin/rails credentials:edit

EDITOR="code --wait" bin/rails credentials:edit --environment production

RAILS_ENV=production bin/rails c
```
1. 开发环境

- config/master.key (密钥)
- config/credentials.yml.enc (加密后的秘文)

密钥 + 秘文 = 还原出来的密码列表

2. 生产环境

- config/credentials/production.key (密钥)
- config/credentials/production.yml.enc (加密后的秘文)

RAILS_MASTER_KEY=OBVIOUSLY_FAKE_PWD pulao_deploy/starter_for_local.sh

## 使用 `Dotenv` 代替 rails 的密钥管理
`rm config/database.yml config/credentials.yml.enc \
config/master.key`

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## 魔改 api-documentation
```
git clone git@github.com:bitecroissant/rspec_api_documentation.git vendor/rspec_api_documentation

gem 'rspec_api_documentation', path: './vendor/rspec_api_documentation'

```