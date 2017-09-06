# ersti-mails tool
Registration form for freshmen mailinglist.
Provides checkbox for newsletter signup as well.

## Installation
Requires [`node >= 6.x`](https://nodejs.org/en/download/package-manager/) and `mysql-server >=5.x`.

```bash
git clone https://github.com/fs-geofs/ersti-mails.git
cd ersti-mails
npm install
mysql -u root -p < schema.sql
echo "SET PASSWORD FOR 'ersti-mails' = PASSWORD('my pass word here')" | mysql -u root -p
cp config.js.sample config.js
```

Now open `config.js` and insert the SQL user password.

At last, create login credentials for the admin panel (requires `htpasswd` from apache-utils):
```
htpasswd -c ./admin.htpasswd <username>
```

You now can start the app by running `npm start`.

There are two frontend endpoints:
- `./`:      contains the user facing forms
- `./admin`: contains an adminpanel, requires authentication

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
