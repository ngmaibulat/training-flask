#!/bin/bash


###  Check if the service exists
###  If it does, pull the latest code and restart the service
###  If it does not, continue with the deployment

service_name="ngmapi"

if systemctl list-units --full --all | grep -Fq "$service_name.service"; then
    echo "Service $service_name exists"

    git config --global --add safe.directory /opt/ngmapi
    cd /opt/ngmapi
    git pull

    ### Deploy nginx reverse proxy.
    ### Or, just update the config

    sudo apt -y install nginx
    sudo cp /opt/ngmapi/scripts/deployment/ngmapi.conf /etc/nginx/sites-available/
    sudo ln -sf /etc/nginx/sites-available/ngmapi.conf /etc/nginx/sites-enabled/ngmapi
    sudo systemctl restart nginx

    sudo systemctl restart ngmapi.service

    ### Update TLS certificate
    sudo systemctl stop nginx
    sudo certbot renew --quiet
    sudo systemctl start nginx

    exit 0
else
    echo "Service $service_name does not exist"
fi


### Install some packages

sudo apt -y install python3-pip
sudo apt -y install python3.10-venv
sudo apt -y install psmisc

### Just some optional tuning

echo 'export PS1="\[\e[1;32m\]\u@\h:\w\$\[\e[0m\] "' >> ~/.bashrc
echo 'alias python=python3' >> ~/.bashrc
echo 'alias pip=pip3' >> ~/.bashrc
source ~/.bashrc

### Clone the repo

export GIT_SSH_COMMAND="ssh -o StrictHostKeyChecking=no"
# export GIT_REPO="https://github.com/ngmaibulat/training-flask.git"
export GIT_REPO="git@github.com:ngmaibulat/training-flask.git"

git clone $GIT_REPO

if [ $? -eq 0 ]; then
    echo "Clone was successful"
else
    echo "Clone failed"
    exit 1
fi

### Move the code to /opt

sudo mkdir -p /opt
sudo mv training-flask /opt/ngmapi
cd /opt/ngmapi

### Install Python packages

sudo pip install gunicorn
sudo pip install -r requirements.txt

### Create user and set file permissions
sudo adduser --system --no-create-home ngm
sudo chown -R ngm:users /opt/ngmapi


### Create a SystemD service

sudo cp scripts/deployment/ngmapi.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable ngmapi.service
sudo systemctl start ngmapi.service
sudo systemctl status ngmapi.service


### Deploy nginx reverse proxy.
### Or, just update the config

sudo apt -y install nginx
sudo cp /opt/ngmapi/scripts/deployment/ngmapi.conf /etc/nginx/sites-available/
sudo ln -sf /etc/nginx/sites-available/ngmapi.conf /etc/nginx/sites-enabled/ngmapi
sudo systemctl restart nginx


### Certbot

sudo apt -y install certbot
sudo systemctl stop nginx
sudo certbot certonly --standalone -d api.ng-labs.com --non-interactive --agree-tos --email nigmatullin@gmail.com

# Certificate is saved at: /etc/letsencrypt/live/api.ng-labs.com/fullchain.pem
# Key is saved at:         /etc/letsencrypt/live/api.ng-labs.com/privkey.pem

sudo systemctl start nginx

### A simple test

export IP=`curl ifconfig.me`
curl http://$IP
curl https://api.ng-labs.com

### Below commands for manual review/debug
# pstree -p 1492
# pstree -pau 1492
