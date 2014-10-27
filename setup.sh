#!/bin/bash -x

make
sudo make install
ln –s /usr/local/lib/faketime /usr/lib/faketime
sudo ln -s /usr/local/lib/faketime/ /usr/lib/faketime
for file in $(ls /etc/cnu/cnu_env.*); do
  echo "export USE_FAKETIME=true"                             >> $file 
  echo "export LD_PRELOAD=/usr/lib/faketime/libfaketime.so.1" >> $file
  echo "export DONT_FAKE_MONOTONIC=1"                         >> $file
done
sudo touch /etc/faketimerc
sudo chown cnuapp:cnuadmin /etc/faketimerc
sudo bash -c "echo LD_PRELOAD = '/usr/lib/faketime/libfaketime.so.1' >> /etc/postgresql/9.1/main/environment"
