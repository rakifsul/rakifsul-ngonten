# Teknik Dasar Pengarsipan Web dengan Kiwix, Zim, dan Aplikasi Lainnya

Beberapa tipe orang, termasuk saya, adalah tipe orang yang ingin mendownload banyak hal.

Sebenarnya, apa yang saya download tidak selalu hal yang sering saya gunakan atau butuhkan.

Namun, entah kenapa, secara psikologis, saya merasa tentram dan damai saat saya berhasil mendownload suatu file, apalagi yang berukuran besar atau berjumlah banyak.

Walaupun terkesan tidak bermanfaat, aktivitas semacam itu menurut saya berguna, karena termasuk dalam pelestarian data.

Dalam melakukan hal tersebut, sebenarnya, banyak tools yang tersedia secara gratis, bahkan open source.

Sebagai contoh, untuk melakukan download seluruh website, kita bisa gunakan:

- Httrack (bisa untuk Windows dan Linux)
- Cyotek WebCopy (hanya Windows)
- wget (sangat populer di Linux)
- zimit (hanya Docker, di Windows harus pakai WSL atau Linux VM)
- RF Website Downloader (buatan saya, banyak bug-nya)

Yang lebih menariknya lagi, kita tidak selalu harus mendownload website dari nol, karena beberapa website lain telah melakukannya. Di situ kita tinggal mendownload arsipnya saja.

Beberapa website tersebut adalah:

- Archive.org dengan query: keyword_anda subject:"warcarchives".
- Kiwix Library

Jika Anda menggunakan Archive.org dengan query tadi, Anda hanya perlu mendownload file berformat warc.gz, mengekstraknya, kemudian menggunakan tools untuk memformatnya menjadi .zim yang bernama warc2zim yang merupakan bagian dari repository zimit.

Jika Anda melakukan pengunduhan website secara manual, Anda memerlukan zimwriterfs yang merupakan bagian dari repository zim-tools yang sebaiknya Anda build sendiri. Ini lebih mudah dilakukan di Linux, jadi, segeralah migrasi ke Linux. Jika Anda lebih suka zim-tools yang sudah jadi, Anda bisa download [di sini](https://download.openzim.org/release/zim-tools/).

OK. Jadi ringkasan dari tulisan tadi adalah seperti ini.

- Jika ingin yang sudah jadi:
    - Kiwix Library => zim siap pakai
    - Archive.org
        - dengan query: keyword_anda subject:"warcarchives"
        - download file warc.gz-nya, biasanya yang paling besar ukurannya
        - kemudian konversi dengan:
            - warc2zim (bagian dari zimit) => jadi zim siap pakai
- Jika ingin mulai dari nol:
    - Linux dan Windows:
        - Httrack
        - wget
        - Kemudian konversi dengan zimwriterfs => jadi zim siap pakai
    - Windows Saja:
        - Cyotek WebCopy (bisa di native Windows)
        - Kemudian konversi dengan zimwriterfs (di Linux atau WSL) => jadi zim siap pakai
    - Docker (Linux, WSL, VM):
        - zimit => hasilnya file zim siap pakai

Poin-poin di atas tujuan akhirnya adalah => membuat file .zim dari website. 

Lalu, mau dibawa ke mana file .zim tersebut?

Setelah zim didapatkan, kita bisa menggunakan Kiwix, baik untuk desktop, Android, maupun versi self hostednya yang bernama kiwix-serve.

Artikel ini akan menjelaskan penggunaan tools-tools yang telah saya sebutkan tadi yang hanya berkaitan dengan Kiwix dan Zim saja.

Itu karena, baik Httrack, Cyotek, serta RF Website Downloader sudah tersedia GUI-nya, harusnya lebih mudah.

## Cara Install Aplikasi-Aplikasi Tadi

Barusan saya sebutkan beberapa tools, tapi saya belum berikan link-nya atau cara installnya. Di sinilah saya akan memberikan hal tersebut.

### Httrack

Httrack bisa Anda dapatkan [di sini](https://www.httrack.com/page/2/en/index.html) jika Anda menggunakan Windows.

Jika Anda menggunakan Ubuntu, Anda bisa jalankan ini:

```
# hanya command line
sudo apt update
sudo apt install httrack

# dengan web ui
sudo apt update
sudo apt install webhttrack
```

### Cyotek WebCopy

Download [di sini](https://www.cyotek.com/cyotek-webcopy).


### RF Website Downloader

Repository-nya ada [di sini](https://github.com/rakifsul/kode-lainnya). Build saja sendiri. Caranya ada [di sini](https://github.com/rakifsul/kode-lainnya/tree/main/rf_website_downloader).

### wget

wget biasanya sudah ada di Linux secara default.

Jika Anda menggunakan distro berbasis Debian dan belum memiliki wget, Anda perlu jalankan:

```
sudo apt update
sudo apt install wget
```

### Zimit

Ini adalah aplikasi berbasis Docker.

Anda perlu install Docker terlebih dahulu, kemudian saat menjalankan perintahnya, gunakan cara ini:

```
# di bawah ini zimit menampilkan output di command line
docker run -it --rm --name zimit -v /home/usernameanda/Documents/Project/Zimit:/output ghcr.io/openzim/zimit zimit

# di bawah ini zimit berjalan di background, ada parameter -d
docker run -d -it --rm --name zimit -v /home/usernameanda/Documents/Project/Zimit:/output ghcr.io/openzim/zimit zimit
```

Jika Anda merasa perintah tadi terlalu panjang dan Anda menggunakan Ubuntu, Anda bisa buat alias di file .bashrc seperti ini:

```
# dengan menampilkan output di command line
alias zimit='docker run -it --rm --name zimit -v /home/usernameanda/Documents/Project/Zimit:/output ghcr.io/openzim/zimit zimit'

# berjalan secara background
alias zimit-d='docker run -d -it --rm --name zimit -v /home/usernameanda/Documents/Project/Zimit:/output ghcr.io/openzim/zimit zimit'
```

Jika karena suatu hal, zimit Anda macet, maka Anda tinggal stop dan remove containernya. Itulah keunggulan Docker untuk keperluan ini.

### Kiwix

Aplikasi ini adalah untuk menampilkan isi dari zim.

Download dan pilih-pilih [di sini](https://kiwix.org/en/applications/).

### zim-tools

Tool terpenting dari zim-tools adalah zimwriterfs yang gunanya untuk mengonversi arsip web mentah menjadi file zim.

zim-tools versi binary bisa Anda dapatkan [di sini](https://download.openzim.org/release/zim-tools/)

Ambil yang versi Linux. Jika Anda tidak pakai Linux, maka cobalah pakai Linux. Setidaknya, gunakan WSL jika Anda harus menggunakan Windows.

Jika Anda ingin membuild-nya dari source code silakan Anda baca sendiri [di repository-nya](https://github.com/openzim/zim-tools), karena tidak saya bahas di sini mengingat caranya rumit.

## Cara Menggunakan Sebagian dari Aplikasi Tadi

Misal, ini hanya misalnya, Anda ingin mendownload seluruh isi https://example.com, maka langkah pertama yang perlu Anda lakukan adalah pergi ke:

- Archive.org
- Kiwix Library

Di Archive.org, gunakan query:

```
example subject:"warcarchives"
```

Di Kiwix Library, Anda tinggal masukkan example.com di input dari Kiwix Library. Pastikan bahasa di-set ke "All Languages" dan Kategori di-set ke "All Categories"

### A. Apakah file arsip bisa ditemukan?

Jika Anda bisa menemukannya di Archive.org, maka download file warc.gz terbesarnya. Selanjutnya, lakukan konversi dari warc ke zim **[C]**.

Jika Anda bisa menemukannya di Kiwix Library, maka download file .zim nya. Selanjutnya, jadikan itu input untuk Kiwix atau kiwix-serve **[G]**.

### B. Apakah file arsip tersebut cukup baru?

Jika menurut Anda cukup, maka lakukan langkah tadi saja **[A]**.

Namun, jika Anda merasa belum cukup, maka lanjut ke langkah download website secara manual **[D]** **[E]**.

### C. Cara Konversi dari warc ke zim

Pada dasarnya, konversi bisa dilakukan dengan aplikasi warc2zim yang berasal dari container zimit.

Perintah yang biasa digunakan adalah:

```
docker run -it --rm -v /home/usernnameanda/Documents/Project/Zimit:/output ghcr.io/openzim/zimit warc2zim /output/nama_file_arsip.warc --output /output --name nama_arsip --title judul_arsip --description "deskripsi arsip" --long-description "deskripsi panjang arsip"
```

Dan sekali lagi, jika Anda pikir perintah tadi terlalu panjang, gunakan alias ini di .bashrc:

```
alias warc2zim='docker run -it --rm --name zimit -v /home/usernnameanda/Documents/Project/Zimit:/output ghcr.io/openzim/zimit warc2zim'
```

Jika Anda melakukan itu, maka perintah yang tadi jadi seperti ini:

```
warc2zim /output/nama_file_arsip.warc --output /output --name nama_arsip --title judul_arsip --description "deskripsi arsip" --long-description "deskripsi panjang arsip"
```

Maka, jika tadi Anda bisa mendapatkan example.com.warc.gz dan mengekstraknya jadi example.com.warc, maka perintah secara keseluruhan untuk mengonversinya menjadi file .zim adalah:


```
warc2zim /output/example.com.warc --output /output --name example.com --title example.com --description "deskripsi example.com" --long-description "deskripsi panjang example.com"
```

Setelah file .zim sudah jadi, masukkan sebagai input dari Kiwix atau Kiwix Serve **[G]**.

### D. Cara Mendownload Website secara Manual dengan zimit

Perintah yang biasa saya gunakan ada di bawah ini jika saya sudah membuat aliasnya:

```
zimit --keep --seeds https://example.com --name example.com.zim --title example.com --description "example website" --long-description "example website" --maxPageRetries 1 --pageLoadTimeout 3 --postLoadDelay 2 --pageExtraDelay 3 --scopeExcludeRx="(search\?|\?showComment|\comments\/default)"
```

--scopeExcludeRx di perintah tadi hanya contoh, gunakan regex di situ. Jika URL match dengan regex tadi maka halaman akan di-skip.

zimit mendownload website sekaligus mengubahnya jadi file .zim jika berhasil. 

Maka, setelah zimit selesai, Anda tinggal masukkan file .zim tadi ke folder zim dari kiwix-serve atau membukanya dengan Kiwix Desktop atau Kiwix Android yang berbasis GUI **[G]**.

### E. Cara Mendownload Website secara Manual dengan wget

Perintah yang biasa saya gunakan ada di bawah ini:

```
wget -r -p -k -e robots=off --html-extension --convert-links --restrict-file-names=windows -U Mozilla -H --span-hosts --domains=example.com,example.org --reject-regex 'ignore1*|ignore2*' https://example.com
```

Nanti hasilnya akan terdiri dari satu atau beberapa folder.

Jika Anda merasa folder tersebut tidak rapi, buat folder khusus dulu, lalu jalankan perintah tadi di folder tersebut.

Jika karena suatu hal download dengan wget macet, Anda tinggal tekan ctrl+c, lalu lanjutkan dengan menambah parameter -c pada perintah tadi, seperti ini:

```
wget -c -r -p -k -e robots=off --html-extension --convert-links --restrict-file-names=windows -U Mozilla -H --span-hosts --domains=example.com,example.org --reject-regex 'ignore1*|ignore2*' https://example.com
```

Setelah selesai, Anda perlu mengubahnya ke file .zim dengan perintah zimwriterfs yang merupakan bagian dari zim-tools **[F]**.

### F. Cara Mengonversi Arsip Web Mentah Menjadi File .zim dengan zimwriterfs

Di sini, apa yang perlu SANGAT Anda perhatikan adalah struktur folder dan di folder mana Anda menjalankan perintah zimwriterfs.

Perintah yang biasanya berhasil saya gunakan ini:

```
zimwriterfs -w example.com/index.html \
            -I example.com/logo.png \
            -l ind \
            -n example.com \
            -t example.com \
            -d "example" \
            -c "the example writer" \
            -p "the example publisher" \
            -v \
            -L "example" \
            ./example.com \
            ./example.com.zim
```

Dijalankan pada folder di atas folder example.com.

Mungkin Anda bingung dengan kalimat di atas.

Saya coba jelaskan.

Saat Anda memulai download dengan wget dengan cara yang telah saya jelaskan sebelumnya, Anda membuat dulu folder example.com, kemudian menjalankan wget di dalamnya.

Di dalam folder example.com, wget bisa jadi mendownload dari website luar example.com, misal saja example.org.

Jika yang terjadi seperti itu, maka folder example.com terdiri dari subfolder:

- example.com/example.org
- example.com/example.com

Ini wajar terjadi, karena sebuah website mungkin mengambil JavaScript dan CSS dari CDN atau yang semacamnya.

wget secara otomatis memisahkannya berdasarkan domain.

POSISI ANDA saat mengonversi file arsip website mentah menjadi zim adalah di atas dari folder example.com teratas:

- folder-posisi-anda
- folder-posisi-anda/example.com/example.org
- folder-posisi-anda/example.com/example.com

Biasanya dengan cara ini saya lebih mudah membayangkannya.

Dan ada beberapa hal lagi. logo.png.

Biasanya saya membuat file logo.png dengan gambar bebas asalkan resolusinya 48x48 pixel.

Letakkan itu di:

- folder-posisi-anda/example.com/example.com/logo.png

Begitu pula, pastikan ada index.html di:

- folder-posisi-anda/example.com/example.com/index.html

Jika Anda tidak menemukan index.html di dalamnya, maka Anda bisa membuat sendiri index.html atau tentukan file html pilihan anda di:

- folder-posisi-anda/example.com/example.com

yang menurut Anda cocok untuk homepage dari file .zim.

Setelah file .zim sudah jadi, masukkan sebagai input dari Kiwix atau Kiwix Serve **[G]**.

## G. Membaca File .zim dengan Kiwix Serve

Jika Anda menggunakan kiwix-serve, Anda bisa menggunakan Docker dengan docker-compose.yml ini:

```
services:
  kiwix-serve:
    container_name: kiwix-serve
    restart: unless-stopped
    ports:
      - 10006:8080
    image: ghcr.io/kiwix/kiwix-serve:3.7.0
    # uncomment next 4 lines to use it with local zim file in /tmp/zim
    volumes:
      - /home/usernameanda/Documents/Kiwix-Serve:/data
    command:
      - '*.zim'
    # uncomment next 2 lines to use it with remote zim file
    environment:
      - PUID=1000
      - PGID=1000
```

Pastikan semua file .zim dimasukkan ke "/home/usernameanda/Documents/Kiwix-Serve" kecuali Anda ubah volumes di docker compose tadi.

## Penutup

Inilah yang menarik dengan file .zim.

File arsip ini sangat berguna, tapi sayangnya hanya sedikit informasi yang siap digunakan untuk menggunakannya.

Saya kira artikel ini berguna jika Anda ingin melakukan pengarsipan web untuk diakses secara lokal.

Jika Anda belum paham parameter yang saya berikan pada contoh-contoh tadi, gunakan parameter --help pada setiap perintah untuk mengetahuinya.

Sekian...
