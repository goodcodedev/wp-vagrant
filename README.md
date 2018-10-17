# Vagrant box for wordpress development
Simple box that sets up LAMP with xdebug.

## Install on vagrant box
Go to `cd vagrant`, run `vagrant up`, then `vagrant ssh` into machine and run `source /vagrant/install.sh`.
You'll be asked for mysql password during install. Currently the script assumes no mysql password.

## Vs-code
Tested with PHP `IntelliSense` and `PHP debug` plugin by Felix Becker.
To configure for debugging, paste the launch configuration in `vscode-launch.json` into `.vscode/launch.json`. This assumes opening `code .` from repository root (possibly it would make more sense to open from wp, in case adjust paths accordingly).