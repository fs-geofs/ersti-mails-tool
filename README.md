# ErstiWeTool
Prototype of ErstiWeTool in nodejs express framework.

## Installation
Requires `node >= 4.x` and `mysql-server >=5.x`.

```bash
git clone https://github.com/SpeckiJ/ErstiWeTool.git
cd ErstiWeTool
npm install
mysql -u root -p < schema.sql
echo "SET PASSWORD FOR 'ersti-we' = PASSWORD('my pass word here')" | mysql -u root -p
cp config.sample.js config.js
```

Now open `config.js` and configure the application to your likings

At last, create login credentials for the admin panel (requires `htpasswd` from apache-utils):
```
htpasswd -c ./admin.htpasswd <username>
```

You now can start the app by running `npm start`.

There are two frontend endpoints:
- './': contains the user facing forms
- './admin': contains an adminpanel, requires authentication

## Autostart
On a system running systemd, you may copy the file `ErstiWeTool` to `/etc/init.d/`, and start the app via
`sudo service ErstiWeTool start`

