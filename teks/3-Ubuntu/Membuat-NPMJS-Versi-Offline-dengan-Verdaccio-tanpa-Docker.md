# Membuat NPMJS Versi Offline dengan Verdaccio tanpa Docker

Untuk berjaga-jaga jika internet sedang offline, saya memikirkan cara untuk mengakses npm registry secara offline, karena Node.js adalah salah satu teknologi yang saya suka dan saya gunakan.

Waktu itu, saya mencoba mencarinya di search engine, kemudian saya menemukan solusi yang siap pakai.

Solusi tersebut bernama [Verdaccio](https://verdaccio.org).

Verdaccio pada dasarnya adalah sebuah aplikasi Node.js juga, tetapi berfungsi sebagai npm registry yang bisa digunakan secara offline.

Setelah melihat dokumentasinya secara sekilas, saya melihat ada dua metode installasi yang perlu saya ketahui: npm install atau docker.

Tadinya, saya mencoba metode dengan docker, namun saya gagal mendapati cache dari package yang terdownload ke dalam Verdaccio storage. Di folder storage-nya, saya hanya menemukan file database-nya saja.

Saya sendiri kurang tahu permasalahannya ada di mana.

Oleh karena itu, akhirnya saya menginstall Verdaccio dengan metode npm install.

Bagaimana saya melakukan itu? Mari kita belajar bersama.

## Menginstall Node.js Version Manager bernama nvm

Sudah jadi kebiasaan saya saat menginstall Node.js atau Python, saya menggunakan version manager.

Untuk Node.js, aplikasi yang saya gunakan adalah [nvm](https://github.com/nvm-sh/nvm).

Cara menginstallnya sangat mudah. Cukup jalankan perintah ini:

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
```

Saya tutup terminal saya, kemudian saya buka lagi.

Selanjutnya, saya menginstall Node.js versi 22 dengan version manager tersebut:

```bash
nvm install 22
```

Versi detail yang saya dapatkan saat itu adalah v22.17.0.

Mengetahui nama versi secara detail Node.js tadi sangat penting, karena kita nanti akan perlu mengakses folder nyata dari Node.js di versi tadi.

Saat ini, saya sudah secara otomatis menggunakan versi v22.17.0. Untuk memastikannya:

```bash
node -v
npm -v
```

## Mengistall Verdaccio secara Lokal

Jika Anda telah melihat di dokumentasi resminya, mungkin Anda akan menyadari bahwa Verdaccio diinstall dengan parameter -g yang artinya global.

Namun, berhubung saya lebih suka menginstallnya secara lokal agar lebih mudah dibackup, saya akan melakukan sedikit modifikasi.

Saya memulainya dengan membuat folder project bernama "Verdaccio".

Kemudian saya buat juga subfolder dan file ini:

-   Verdaccio/vdc
-   Verdaccio/vdc-data
-   Verdaccio/vdc-data/plugins
-   Verdaccio/vdc-data/storage
-   Verdaccio/vdc-data/config.yaml
-   Verdaccio/vdc-data/htpasswd
-   Verdaccio/run-verdaccio.sh

Setelah itu, saya masuk kedalam folder "Verdaccio/vdc" dan melakukan:

```bash
npm init -y
```

Dan melanjutkannya dengan:

```bash
npm install verdaccio
```

Nanti jika Anda lihat package.json, verdaccio ada dalam dependency list dan package nya ada di node\_modules.

Saya melanjutkannya dengan menulis script "Verdaccio/run-verdaccio.sh" ini:

```bash
#!/bin/bash

SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

/home/namauser/.nvm/versions/node/v22.17.0/bin/node $SCRIPTPATH/vdc/node_modules/verdaccio/bin/verdaccio.js --config $SCRIPTPATH/vdc-data/config.yaml
```

Sesuaikan namauser dengan milik Anda dan versi Node.js di atas dengan Node.js yang Anda install tadi.

Kemudian, saya memberi permission kepada file tersebut agar bisa diexecute:

```bash
sudo chmod +x ./run-verdaccio.sh
```

Kemudian, saya membuat symbolic link dengan menu klik kanan di Nautilus > create link.

Link tersebut saya rename jadi "run-verdaccio.sh" di folder lain agar tidak konflik nama filenya.

Setelah itu, saya pindahkan link "run-verdaccio.sh" ke "/usr/bin" yang pada akhirnya nama path lengkap dari link tadi adalah "/usr/bin/run-verdaccio.sh".

Selanjutnya, saya mengisi "Verdaccio/vdc-data/config.yaml" dengan ini:

```yaml
#
# This is the default configuration file. It allows all users to do anything,
# please read carefully the documentation and best practices to
# improve security.
#
# Look here for more config file examples:
# https://github.com/verdaccio/verdaccio/tree/6.x/conf
#
# Read about the best practices
# https://verdaccio.org/docs/best

# path to a directory with all packages
storage: ./storage
# path to a directory with plugins to include
plugins: ./plugins

# https://verdaccio.org/docs/webui
web:
  title: Verdaccio
  # comment out to disable gravatar support
  # gravatar: false
  # by default packages are ordercer ascendant (asc|desc)
  # sort_packages: asc
  # convert your UI to the dark side
  # darkMode: true
  # html_cache: true
  # by default all features are displayed
  # login: true
  # showInfo: true
  # showSettings: true
  # In combination with darkMode you can force specific theme
  # showThemeSwitch: true
  # showFooter: true
  # showSearch: true
  # showRaw: true
  # showDownloadTarball: true
  #  HTML tags injected after manifest <scripts/>
  # scriptsBodyAfter:
  #    - '<script type="text/javascript" src="https://my.company.com/customJS.min.js"></script>'
  #  HTML tags injected before ends </head>
  #  metaScripts:
  #    - '<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>'
  #    - '<script type="text/javascript" src="https://browser.sentry-cdn.com/5.15.5/bundle.min.js"></script>'
  #    - '<meta name="robots" content="noindex" />'
  #  HTML tags injected first child at <body/>
  #  bodyBefore:
  #    - '<div id="myId">html before webpack scripts</div>'
  #  Public path for template manifest scripts (only manifest)
  #  publicPath: http://somedomain.org/

# https://verdaccio.org/docs/configuration#authentication
auth:
  htpasswd:
    file: ./htpasswd
    # Maximum amount of users allowed to register, defaults to "+inf".
    # You can set this to -1 to disable registration.
    # max_users: 1000
    # Hash algorithm, possible options are: "bcrypt", "md5", "sha1", "crypt".
    # algorithm: bcrypt # by default is crypt, but is recommended use bcrypt for new installations
    # Rounds number for "bcrypt", will be ignored for other algorithms.
    # rounds: 10

# https://verdaccio.org/docs/configuration#uplinks
# a list of other known repositories we can talk to
uplinks:
  npmjs:
    url: https://registry.npmjs.org/

# Learn how to protect your packages
# https://verdaccio.org/docs/protect-your-dependencies/
# https://verdaccio.org/docs/configuration#packages
packages:
  '@*/*':
    # scoped packages
    access: $all
    publish: $authenticated
    unpublish: $authenticated
    proxy: npmjs

  '**':
    # allow all users (including non-authenticated users) to read and
    # publish all packages
    #
    # you can specify usernames/groupnames (depending on your auth plugin)
    # and three keywords: "$all", "$anonymous", "$authenticated"
    access: $all

    # allow all known users to publish/publish packages
    # (anyone can register by default, remember?)
    publish: $authenticated
    unpublish: $authenticated

    # if package is not available locally, proxy requests to 'npmjs' registry
    proxy: npmjs

# To improve your security configuration and  avoid dependency confusion
# consider removing the proxy property for private packages
# https://verdaccio.org/docs/best#remove-proxy-to-increase-security-at-private-packages

# https://verdaccio.org/docs/configuration#server
# You can specify HTTP/1.1 server keep alive timeout in seconds for incoming connections.
# A value of 0 makes the http server behave similarly to Node.js versions prior to 8.0.0, which did not have a keep-alive timeout.
# WORKAROUND: Through given configuration you can workaround following issue https://github.com/verdaccio/verdaccio/issues/301. Set to 0 in case 60 is not enough.
server:
  keepAliveTimeout: 60
  # Allow `req.ip` to resolve properly when Verdaccio is behind a proxy or load-balancer
  # See: https://expressjs.com/en/guide/behind-proxies.html
  # trustProxy: '127.0.0.1'

# https://verdaccio.org/docs/configuration#offline-publish
# publish:
#   allow_offline: false

# https://verdaccio.org/docs/configuration#url-prefix
# url_prefix: /verdaccio/
# VERDACCIO_PUBLIC_URL='https://somedomain.org';
# url_prefix: '/my_prefix'
# // url -> https://somedomain.org/my_prefix/
# VERDACCIO_PUBLIC_URL='https://somedomain.org';
# url_prefix: '/'
# // url -> https://somedomain.org/
# VERDACCIO_PUBLIC_URL='https://somedomain.org/first_prefix';
# url_prefix: '/second_prefix'
# // url -> https://somedomain.org/second_prefix/'

# https://verdaccio.org/docs/configuration#security
# security:
#   api:
#     legacy: true
#     # recomended set to true for older installations
#     migrateToSecureLegacySignature: true
#     jwt:
#       sign:
#         expiresIn: 29d
#       verify:
#         someProp: [value]
#    web:
#      sign:
#        expiresIn: 1h # 1 hour by default
#      verify:
#         someProp: [value]

# https://verdaccio.org/docs/configuration#user-rate-limit
# userRateLimit:
#   windowMs: 50000
#   max: 1000

# https://verdaccio.org/docs/configuration#max-body-size
# max_body_size: 10mb

# https://verdaccio.org/docs/configuration#listen-port
# listen:
# - localhost:4873            # default value
# - http://localhost:4873     # same thing
# - 0.0.0.0:4873              # listen on all addresses (INADDR_ANY)
# - https://example.org:4873  # if you want to use https
# - "[::1]:4873"                # ipv6
# - unix:/tmp/verdaccio.sock    # unix socket

# The HTTPS configuration is useful if you do not consider use a HTTP Proxy
# https://verdaccio.org/docs/configuration#https
# https:
#   key: ./path/verdaccio-key.pem
#   cert: ./path/verdaccio-cert.pem
#   ca: ./path/verdaccio-csr.pem

# https://verdaccio.org/docs/configuration#proxy
# http_proxy: http://something.local/
# https_proxy: https://something.local/

# https://verdaccio.org/docs/configuration#notifications
# notify:
#   method: POST
#   headers: [{ "Content-Type": "application/json" }]
#   endpoint: https://usagge.hipchat.com/v2/room/3729485/notification?auth_token=mySecretToken
#   content: '{"color":"green","message":"New package published: * {{ name }}*","notify":true,"message_format":"text"}'

middlewares:
  audit:
    enabled: true

# https://verdaccio.org/docs/logger
# log settings
log: { type: stdout, format: pretty, level: http }
#experiments:
#  # support for npm token command
#  token: false
#  # disable writing body size to logs, read more on ticket 1912
#  bytesin_off: false
#  # enable tarball URL redirect for hosting tarball with a different server, the tarball_url_redirect can be a template string
#  tarball_url_redirect: 'https://mycdn.com/verdaccio/${packageName}/${filename}'
#  # the tarball_url_redirect can be a function, takes packageName and filename and returns the url, when working with a js configuration file
#  tarball_url_redirect(packageName, filename) {
#    const signedUrl = // generate a signed url
#    return signedUrl;
#  }

# translate your registry, api i18n not available yet
# i18n:
# list of the available translations https://github.com/verdaccio/verdaccio/blob/master/packages/plugins/ui-theme/src/i18n/ABOUT_TRANSLATIONS.md
#   web: en-US
```

Kemudian saya menyimpannya dan exit.

## Mendaftarkan Verdaccio tadi ke Systemd

Agar Verdaccio berjalan otomatis saat Ubuntu dimulai, saya mendaftarkannya ke Systemd.

Saya mulai dengan membuat scriptnya dulu:

```bash
nano ~/.config/systemd/user/verdaccio.service
```

Saya mengisinya dengan script ini:

```ini
[Unit]
Description=Start verdaccio at login
After=graphical-session.target

[Service]
ExecStart=/usr/bin/run-verdaccio.sh
Restart=always

[Install]
WantedBy=default.target
```

Kemudian saya save dan exit.

Selanjutnya, saya jalankan perintah ini:

```bash
loginctl enable-linger $USER

sudo loginctl enable-linger $USER

systemctl --user daemon-reexec

systemctl --user daemon-reload

systemctl --user enable verdaccio.service

systemctl --user start verdaccio.service
```

## Menguji Verdaccio

Untuk memastikan bahwa Verdaccio tadi berjalan saat Ubuntu dimulai, saya merestart komputer saya dan membuka http://localhost:4873 

Karena sudah benar, saya lanjut ke langkah berikutnya.

## Mencoba Menginstall Package NPM

Sebelum kita bisa menginstall package, kita harus melakukan registrasi dulu.

```bash
npm adduser --registry http://localhost:4873/
```

Saya set npm registry default ke localhost:4873:

```bash
npm set registry http://localhost:4873/
```

Selanjutnya, saya tutup terminal, dan saya buka lagi.

Dalam keadaan terminal seperti ini, saya harus login dulu:

```bash
npm login --registry http://localhost:4873
```

Kemudian, saya install express untuk percobaan:

```bash
npm install express
```

Jika Verdaccio berjalan dengan benar, maka Anda bisa melihat package express di folder "Verdaccio/vdc-data/storage".

## Kesimpulan

Jadi, jika Anda ingin dapat melakukan npm install saat offilne, Anda bisa menggunakan Verdaccio, tapi asumsinya adalah package yang akan Anda install pernah diinstall sebelumnya dengan cara tadi dan jika Verdaccio berjalan dengan benar.