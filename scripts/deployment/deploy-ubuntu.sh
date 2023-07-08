service_name="ngmapi"

if systemctl list-units --full --all | grep -Fq "$service_name.service"; then
    echo "Service $service_name exists"
    git config --global --add safe.directory /opt/ngmapi
    cd /opt/ngmapi
    git pull
    sudo systemctl restart ngmapi.service
    exit 0
else
    echo "Service $service_name does not exist"
fi

echo 'export PS1="\[\e[1;32m\]\u@\h:\w\$\[\e[0m\] "' >> ~/.bashrc

sudo apt -y install python3-pip
sudo apt -y install python3.10-venv
sudo apt -y install psmisc

echo 'alias python=python3' >> ~/.bashrc
echo 'alias pip=pip3' >> ~/.bashrc

source ~/.bashrc

export GIT_SSH_COMMAND="ssh -o StrictHostKeyChecking=no"

# git clone git@github.com:ngmaibulat/training-flask.git

git clone https://github.com/ngmaibulat/training-flask.git

if [ $? -eq 0 ]; then
    echo "Clone was successful"
else
    echo "Clone failed"
    exit 1
fi


sudo mkdir -p /opt
sudo mv training-flask /opt/ngmapi

cd /opt/ngmapi

sudo pip install gunicorn

sudo pip install -r requirements.txt

sudo adduser --system --no-create-home ngm

sudo chown -R ngm:users /opt/ngmapi

sudo cp scripts/deployment/ngmapi.service /etc/systemd/system/

sudo systemctl daemon-reload

sudo systemctl enable ngmapi.service

sudo systemctl start ngmapi.service

sudo systemctl status ngmapi.service

# pstree -p 1492
# pstree -pau 1492
