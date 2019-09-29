#!/bin/bash
python_interpreter=""
domain_name=""
current_folder_name=${PWD##*/}
echo "$result"

read -p "Python interpreter: " python_interpreter
read -p "Your domain without protocol (for example, google.com): " domain_name
`$python_interpreter -m venv env`
source env/bin/activate
pip install -U pip
pip install -r requirements.txt

sed -i "s/project1/$current_folder_name/g" nginx/site.conf systemd/gunicorn.service
sed -i "s/templatedomain/$domain_name/g" nginx/site.conf src/config/settings.py


sudo ln -s /home/www/code/$current_folder_name/nginx/site.conf /etc/nginx/sites-enabled/
sudo ln -s /home/www/code/$current_folder_name/systemd/gunicorn.service /etc/systemd/system/

sudo systemctl daemon-reload
sudo systemctl start gunicorn
sudo systemctl enable gunicorn
sudo service nginx restart
