#!/bin/bash

doctl compute droplet list

doctl compute size list

doctl compute image list

doctl compute image list-distribution ubuntu --public | grep 22

doctl compute region list

doctl compute region list | grep Frank
