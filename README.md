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

Для заполнения БД фейковыми данными `rake db:populate:all`, если необходимо добавить фото на `Cloudinary` `rake db:populate:all['cloudinary']`, для этого надо настроить в файле `config/cloudinary.yml` окружение `development`(зарегестрироваться на сайте и получить нужные ключи).

Это даст трех пользователей с разными ролями `[admin, organizer, moderator]@foo.bar` соответственно. Пароль `12345678`, очистит всю старую базу данных, загрузит по новой список городов, и создаст случайно сгенерированные группы и закупки.

Для запуска тестов для линукс необходимо установить Xvfb


### Pull Request

Инструкции и рекомендации по открытию пулреквестов можно посомтреть [здесь](https://github.com/rails-up/zakupki/blob/master/CONTRIBUTING.md)
