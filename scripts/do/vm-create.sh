
doctl compute droplet create api.ng-labs.com --size s-1vcpu-512mb-10gb --image ubuntu-22-10-x64 --region fra1 --ssh-keys 37590350

doctl compute droplet delete api.ng-labs.com -f

