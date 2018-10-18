# Vagrant box for wordpress development
Simple box that sets up LAMP with xdebug.

## Install on vagrant box
* Go to `cd vagrant`
* Run `vagrant up`
* Then `vagrant ssh` into machine
* And run `source /vagrant/install.sh`. You'll be asked to set up mysql password during install. Currently the script assumes no mysql password, press enter for this.
* Then `exit` out, and `vagrant ssh` in again for group permissions to register
* Run `source /vagrant/install-wp.sh`

## Vs-code
Tested with `PHP IntelliSense` and `PHP debug` plugin by Felix Becker.
To configure for debugging, paste the configuration in `vscode-launch.json` into `.vscode/launch.json`. This assumes opening `code .` from repository root (possibly it would make more sense to open from wp, in case adjust paths accordingly).

Mysql plugin by Jun Han should also work. Use `192.168.33.10` as host, `wordpress` as user and `wppass` as password.