sudo systemctl enable mysql
sudo systemctl start mysql
curl https://dist.crystal-lang.org/apt/setup.sh | sudo bash
sudo apt-get install crystal
bundle config set path 'vendor/bundle'