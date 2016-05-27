# Проект по созданию ресурса совместных покупок

Рабочее название zakupki_app

[![Build Status](https://travis-ci.org/rails-up/zakupki.svg?branch=master)](https://travis-ci.org/rails-up/zakupki)

### Настройка аутентификации через Vkontakte

Разработчикам: Добавлен гем Figaro для хранения токенов. Чтобы работал вход через ВК на вашем локальном сервере, не забудьте добавить файл `config/application.yml` со следующим содержанием:

```
VK_APP_ID: "ваш app id"
VK_APP_KEY: "ваш app key""
VK_CALLBACK_URL: "http://localhost:3000/users/auth/vkontakte/callback"
```

для разработки на локальном сервере необходимо войти в учетку вк и создать там приложение:
`http://vk.com/editapp?act=create`

Далее в настройках приложения в полях "адрес сайта" и "базовый домен" указать тот адрес, на котором у вас запущен сервер, например
`http://localhost:3000`

В поле "доверенный redirect URI" указать тот же самый url, который указан в настройках приложения по ключу 'VK_CALLBACK_URL', например
`http://localhost:3000/users/auth/vkontakte/callback`

файл уже добавлен в .gitignore.

### Data seed/populate

Для заполнения БД фейковыми данными `rake db:seed`, для создания списка городов затем `rake db:populate`.

Это даст трех пользователей с разными ролями `[admin, organizer, moderator]@foo.bar` соответственно. Пароль `12345678`

Для запуска тестов для линукс необходимо установить Xvfb


### Pull Request

Инструкции и рекомендации по открытию пулреквестов можно посомтреть [здесь](https://github.com/rails-up/zakupki/blob/master/CONTRIBUTING.md)
=======
## Инструкция: как синхронизировать мастер-ветку своего форка с мастером основного репозитория

* добавляем апстрим (это делается однократно, больше повторять не нужно)

`git remote add upstream https://github.com/rails-up/zakupki.git`
​
* синхронизируем мастер форка с мастером апстрима (это делается каждый раз)

```
git fetch upstream
git checkout master
git rebase upstream/master
git push -f origin master
```
​
* сольем мастер форка со своими изменениями

```
git checkout my_branch
git merge master
```
* вот тут могут появиться сообщения об ошибках с указанием конкретных файлов
* надо их исправить вручную и закоммитить
​
```
git add .
git commit -m "fix merge conflicts"
git push -fu origin my_branch
```
