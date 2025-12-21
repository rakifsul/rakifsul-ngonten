# Cara Membuat Aplikasi Code-Server jadi Portable di Ubuntu 24.04

Code-Server adalah aplikasi yang cukup berguna di era self hosted akhir-akhir ini, terutama untuk coding secara remote.

Alih-alih menggunakan docker maupun podman, saya mencoba berhemat resource dengan menggunakan wujud aslinya: node.js dan npm dan juga secara portable.

Dan itu saya lakukan di sistem operasi Ubuntu 24.04.

Bukan berarti saya mengekstrak container atau image dari dockernya, melainkan dengan menggunakan metode install via npm, cara yang biasa digunakan untuk menginstall Code-Server di Windows.

Ternyata bisa juga dilakukan di Ubuntu 24.04.

Dengan begini, saya jadi bisa menggunakannya baik di komputer lokal maupun di mini pc server saya.

Bagaimana bisa? Ayo kita simak.

## Download dulu Node.js-nya

Pertama, kita perlu mendownload versi portable dari Node.js v20.x dari website resminya.

Ambil versi 20.x terbaru yang disediakan, kemudian pilih yang untuk linux.

Nanti kita akan mendapati file archive dari Node.js yang jika diekstrak, sudah ada binary-nya.

Selanjutnya, ekstrak archive tadi, rename foldernya jadi "node".

Buat folder baru, katakanlah "Code-Server-Portable" dan buat folder bernama "bin" di dalamnya.

Lalu, masuk dan copy "node" ke dalam folder "bin".

## Menyusun Subfolder untuk Data Code-Server

Sekarang Anda berada di folder "bin", yang mana berada dalam folder "Code-Server-Portable".

Jalankan perintah ini baris per baris:

```
mkdir code-server
cd code-server
mkdir configs
mkdir data
mkdir extensions
nano configs/config.yaml
```

Setelah Anda me-nano-kan config.yaml, isi dengan:

```
bind-addr: 127.0.0.1:8100
auth: none
password: password
cert: false
```

## Memulai Installasi Code-Server

Sekarang, jalankan perintah ini di dalam folder "bin/code-server":

```
../node/bin/npm init -y
../node/bin/npm install yarn
```

Setelah langkah tadi, akan muncul file "package.json".

Di bagian scripts dari "package.json", replace dengan ini:

```
"scripts": {
    "code-server-install": "yarn add code-server@4.100.2"
},
```

Kemudian, di terminal, di dalam folder "bin/code-server", jalankan perintah ini:

```
../node/bin/npm run code-server-install
```

Di situ prosesnya agak lama, jadi tunggu saja.

Setelah selesai tanpa error, kita bisa berasumsi bahwa Code-Server terinstall dengan benar.

Untuk memastikannya, lanjut ke langkah berikutnya.

## Membuat Script Bash untuk Runner-nya

Sekarang, masuk ke folder "Code-Server-Portable".

Buat file baru bernama Runner.sh, kemudian isi dengan script ini:

```
#!/bin/bash

export PATH="$(pwd)/bin/node/bin:$PATH"
export PATH="$(pwd)/bin/code-server/node_modules/.bin:$PATH"
    
code-server --config="$(pwd)/bin/code-server/configs/config.yaml" --user-data-dir="$(pwd)/bin/code-server/data" --extensions-dir="$(pwd)/0bin/code-server/extensions"
```

Save, kemudian beri akses untuk bisa di-execute, biasanya dengan perintah:

```
sudo chmod +x Runner.sh 
```

atau di Ubuntu file explorer, klik kanan > properties > Executable as Program > toggle enable.

Selanjutnya, klik kanan pada icon Runner.sh > Run as Program.

Jika muncul layar terminal, tentunya dengan pesan-pesan log dan URL aksesnya, maka kita berhasil.

Selanjutnya kunjungi saja URL yang muncul di terminal dengan browser Anda.

URL defaultnya adalah:

[http://127.0.0.1:8100](http://127.0.0.1:8100)

## Akhir Kata

Sekian dan baca terus blog saya.