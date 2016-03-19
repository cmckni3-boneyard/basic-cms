# Basic CMS Application

## included packages:

* Express
* Bootstrap 3
* Font Awesome
* jQuery
* Less
* CoffeeScript
* Jade
* Socket.IO
* Modernizr
* es5-shim
* Knockout
* Mongoose

## How to run in development mode:

* clone the app and install dependencies:

```bash
git clone git@github.com:cmckni3/basic-cms.git
cd basic-cms
npm install
bower install
```

* copy the sample config files:

```bash
grunt setup
```

* edit the config files in app/config to your liking

* seed the database

```bash
grunt db:seed
```

* run the server using nodemon:

```bash
grunt
```

## How to deploy production

Note: This deploy process is specific to CentOS machines with nginx compiled with the passenger module.

* create a user account on the host machine called `basic-cms` and set it up:

```bash
adduser basic-cms
chmod 755 /home/basic-cms
su - basic-cms
ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub
```

* copy the key into a new deploy key for this app

* clone the app into `sites` in the user's home folder and install dependencies:

```bash
mkdir sites
cd sites
git clone git@github.com:cmckni3/basic-cms.git
cd basic-cms
npm install
bower install
```

* copy the sample config files:

```bash
grunt setup
```

* edit the config files in app/config to your liking
  * Note: make sure to change `env` to `production` in `app/config/app.coffee`
  * Note: make sure to set `serverNames` in `app/config/nginx.coffee`

* seed the database

```bash
grunt db:seed
```

* set up the nginx config and reload the nginx config

```bash
su -c "grunt setup-nginx"
su -c "service nginx reload"
```

* compile the assets and restart the application:

```bash
grunt production
```

## How to update a production deployment

* pull the changes:

```bash
git pull
```

* install any new dependencies:

```bash
npm install
bower install
```

* recompile the assets and restart the application:

```bash
grunt production
```
