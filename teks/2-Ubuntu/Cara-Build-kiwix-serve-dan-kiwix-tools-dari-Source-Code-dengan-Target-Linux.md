# Cara Build kiwix-serve dan kiwix-tools dari Source Code dengan Target Linux

kiwix-serve adalah aplikasi web untuk membuka file .zim.

File .zim itu sendiri adalah file berisi halaman-halaman web yang dipaketkan ke dalam satu file.

kiwix-serve merupakan bagian dari paket [kiwix-tools](https://github.com/kiwix/kiwix-tools), jadi jika ingin membuild kiwix-serve, kita harus membuild seluruh bagian dari kiwix-tools.

kiwix-tools memiliki dependencies berupa [libzim](https://github.com/openzim/libzim) dan [libkiwix](https://github.com/kiwix/libkiwix).

Idealnya, kedua dependencies tersebut dibuild dari source code juga, agar tetap dalam kondisi terbaru.

Salah satu file zim yang terbesar sepengetahuan saya adalah file zim berisi Wikipedia. Ukurannya sekitar 100 GB.

Jika Anda tertarik untuk mendownloadnya, Anda bisa kunjungi [Kiwix Library](https://library.kiwix.org/#lang=&q=).

Karena saya pernah punya keinginan untuk memodifikasi fitur search dari kiwix-serve, maka tidak ada salahnya jika saya mulai dari membuild kiwix-tools dari source code terlebih dahulu.

Bagaimana caranya? Terus simak!

## Clone Repository

Berikut ini adalah repository yang harus di-clone:

```bash
git clone https://github.com/openzim/libzim.git
git clone https://github.com/kiwix/libkiwix.git
git clone https://github.com/kiwix/kiwix-tools.git
```

## Install Dependency di Sistem Operasi

Ini dependency yang diperlukan di Kubuntu 24.04.3. Install dengan cara ini:

```bash
sudo apt install meson pkg-config ninja-build libicu-dev libzim-dev libpugixml-dev libcurl4-openssl-dev libmicrohttpd-dev zlib1g-dev libdocopt-dev liblzma-dev libzstd-dev libxapian-dev
```

## Build Pertama

Pertama, build libzim:

```bash
meson . build
ninja -C build
ninja -C build install
```

## Build Kedua

Kedua, build libkiwix.

Sebelumnya, ubah dahulu meson.build-nya bagian ini:

```apacheconf
if compiler.has_header('mustache.hpp', args: '-I/path/absolut/ke/rakifsul')
  extra_include = ['./rakifsul']
elif compiler.has_header('mustache.hpp', args: '-I/usr/include/kainjow')
  extra_include = ['/usr/include/kainjow']
else
  error('Cannot found header mustache.hpp')
endif
```

Penjelasannya....

mustache.hpp download di:

[https://github.com/kainjow/Mustache/blob/master/mustache.hpp](https://github.com/kainjow/Mustache/blob/master/mustache.hpp) 

Lalu masukkan mustache.hpp ke folder "rakifsul" yang ada di root folder dari source code libkiwix.

Jika folder tersebut belum ada maka buat sendiri.

### TIPS:

Jika Anda ingin menggunakan nama lain, misalnya "random", maka ganti kode meson build-nya jadi seperti ini:

```bash
if compiler.has_header('mustache.hpp', args: '-I/path/absolut/ke/random')
  extra_include = ['./random']
elif compiler.has_header('mustache.hpp', args: '-I/usr/include/kainjow')
  extra_include = ['/usr/include/kainjow']
else
  error('Cannot found header mustache.hpp')
endif
```

Lalu masukkan mustache.hpp ke folder "random" yang ada di root folder dari source code libkiwix.

Jika folder tersebut belum ada maka buat sendiri.

Selanjutnya, jalankan ini:

```bash
meson . build
ninja -C build
ninja -C build install
```

## Build Terakhir

Terakhir, build kiwix-tools:

```bash
meson . build
ninja -C build

# hasilnya di kiwix-tools/builddir/src/
```

Hasilnya ada di folder repository kiwix-tools, tepatnya di dalam folder kiwix-tools/builddir/src.

## Selesai