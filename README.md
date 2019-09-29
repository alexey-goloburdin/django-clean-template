Это чистый шаблон Django проекта, с которым можно быстро начать разработку. В шаблон входит конфиг Systemd, nginx, gunicorn.

1. В конфигах замените `project1` на ваше название проекта (это название папки в `/home/www/code/`), а также замените название домена:

```bash
sed -i "s/project1/myproject/" nginx/site.conf systemd/gunicorn.service
sed -i "s/templatedomain/yandex.ru/" nginx/site.conf src/config/settings.py
```

2. Создать симлинки на nginx и systemd конфиги, запустить сервис systemd, перезапустить nginx:

```bash
sudo ln -s /home/www/code/project1/nginx/site.conf /etc/nginx/sites-enabled/
sudo ln -s /home/www/code/project1/systemd/gunicorn.service /etc/systemd/system/

sudo systemctl start gunicorn
sudo systemctl enable gunicorn
sudo nginx -s reload
```

В конфиге Django заполните настройки базы данных (`src/config/settings.py`).


Посмотреть статус gunicorn демона:

```bash
sudo systemctl status gunicorn
```

Лог gunicorn'а (`-f` как в `tail -f`):

```bash
sudo journalctl -fu gunicorn
```

После изменения systemd конфига надо перечитать его и затем перезапустить юнит:

```bash
sudo systemctl daemon-reload
sudo systemctl restart gunicorn
```
