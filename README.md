1. Заменить project1 на название проекта:

```bash
sed -i "s/project1/salesbeat/" nginx/site.conf systemd/gunicorn.service
```

2. Создать симлинки на nginx и systemd конфиги, запустить сервис systemd, перезапустить nginx:

```bash
sudo ln -s /home/www/code/project1/nginx/site.conf /etc/nginx/sites-enabled/
sudo ln -s /home/www/code/project1/systemd/gunicorn.service /etc/systemd/system/

sudo systemctl start gunicorn
sudo systemctl enable gunicorn
sudo nginx -s reload
```

Статус gunicorn демона:

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

