# ersti-mails tool
Registration form for freshmen mailinglist.
Provides checkbox for newsletter signup as well.

## Installation
Requires [`node ^6.x`](https://nodejs.org/en/download/package-manager/), [`yarn`](https://yarnpkg.com/en/docs/install) and `mysql-server ^5.7`.

```bash
git clone https://github.com/fs-geofs/ersti-mails.git
cd ersti-mails
yarn install
mysql -u root -p < schema.sql
echo "SET PASSWORD FOR 'ersti-mails' = PASSWORD('my pass word here')" | mysql -u root -p
cp config.js.sample config.js
```

Now open `config.js` and insert the SQL user password.

At last, create login credentials for the admin panel (requires `htpasswd` from apache-utils):
```
htpasswd -c ./admin.htpasswd <username>
```

## Run
You now can start the app by running `yarn start`.

There are two frontend endpoints:
- `./`:      contains the user facing forms
- `./admin`: contains an adminpanel, requires authentication

## Database via docker
```sh
# the root pw is set in docker-compose.yml
docker-compose up -d mysql
docker-compose exec mysql bash -c 'mysql --default-character-set=utf8 -p < schema.sql'
docker-compose exec mysql bash -c "echo 'SET PASSWORD FOR \"ersti-we\" = PASSWORD(\"test\")' | mysql -p"
```

## run as service
### systemd
```bash
vi init/ersti-mails.service # change installation path
sudo cp init/ersti-mails.service /etc/systemd/system/
sudo systemctl enable ersti-mails
sudo systemctl start ersti-mails
```

### upstart
```bash
vi init/ersti-mails # change installation path
sudo cp init/ersti-mails /etc/init.d/
sudo update-rc.d ersti-mails defaults 98 02
sudo service ersti-mails start
```
