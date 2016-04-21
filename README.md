# Проект по созданию ресурса совместных покупок

Рабочее название zakupki_app

[![Build Status](https://travis-ci.org/rails-up/zakupki.svg?branch=master)](https://travis-ci.org/rails-up/zakupki)

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

Для заполнения БД фейковыми данными `rake db:seed`, для создания списка городов затем `rake db:populate`.
