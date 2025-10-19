# Aplikasi Self-Hosted Terbaik Menurut RAKIFSUL Ngonten - Layak Anda Coba

Setelah saya mencoba menginstall cukup banyak aplikasi self hosted, terutama yang menggunakan Docker, saya menyimpulkan bahwa beberapa di antara aplikasi tersebut adalah aplikasi yang paling cocok untuk saya. 

Setidaknya, hingga saat ini aplikasi-aplikasi tersebut belum saya uninstall dan masih saya pakai.

Berikut ini adalah daftar aplikasi-aplikasi tersebut.

## Portainer

Aplikasi untuk manajemen docker berbasis web self hosted. Ini adalah salah satu aplikasi pertama yang saya install setiap kali saya baru menginstall Linux.

Fitur-fitur penting:

-   Manajemen container
-   Manajemen volume
-   Manajemen image
-   Manajemen network
-   Template aplikasi
-   Stacks
-   Container console
-   Container logs
-   Dan lain-lain

Kelebihan:

-   Sangat ringan dan cepat
-   Intuitif (bagi saya)
-   Tampilan user friendly
-   Fitur sangat lengkap

Tips teknis:

-   Sebaiknya install dengan Docker

Penggunaan kreatif:

-   Dijadikan sebagai aplikasi dashboard.

Link penting:

-   [https://github.com/portainer/portainer](https://github.com/portainer/portainer)

Cara install:

```bash
# buat volume
docker volume create portainer_data

# pakai port 9000
docker run -d -it -p 9000:9000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest

# selanjutnya, kunjungi:
http://127.0.0.1:9000
```

## SearXNG

Aplikasi search engine berbasis web self hosted. Ini adalah aplikasi yang saya gunakan untuk searching saat saya ingin hasil yang anti mainstream.

Fitur-fitur penting:

-   Search dari berbagai sumber yang bisa diaktifkan dan dinonaktifkan
-   Filter search result
-   Search web
-   Search image
-   Search video
-   Search news
-   Search map
-   Search music
-   Search file
-   Search social media

Kelebihan:

-   Sangat ringan dan cepat
-   Tampilan user friendly
-   Mudah dimodifikasi dari source code

Tips teknis:

-   Sebaiknya install dengan Docker

Penggunaan kreatif:

-   Belum terpikirkan oleh saya.

Link penting:

-   [https://github.com/searxng/searxng](https://github.com/searxng/searxng)

## File Browser

Aplikasi file explorer berbasis web self hosted. Saya menggunakan ini sebagai image dan video gallery karena beberapa file format bisa langsung dipreview di aplikasi tersebut.

Fitur-fitur penting:

-   Manajemen file dan folder
-   Preview file gambar
-   Preview file video
-   Custom CSS

Kelebihan:

-   Sangat ringan dan cepat
-   Intuitif (bagi saya)
-   Tampilan user friendly

Tips teknis:

-   Bisa dengan Docker atau tanpa Docker

Penggunaan kreatif:

-   Dijadikan sebagai aplikasi galeri gambar dan video.

Link penting:

-   [https://github.com/filebrowser/filebrowser](https://github.com/filebrowser/filebrowser)

## kiwix-serve (bagian dari kiwix-tools)

Aplikasi zim viewer berbasis web self hosted. Aplikasi ini bisa digunakan untuk mengakses Wikipedia dan file zim lainnya secara offline.

Fitur-fitur penting:

-   Menampilkan seluruh isi website yang sudah dikonversi menjadi file zim. Contoh yang paling besar ukurannya adalah Wikipedia full version.
-   Menampilkan daftar file zim
-   Mencari dalam daftar file zim
-   Memfilter file zim dalam kategori
-   Mencari secara internal dalam file zim yang telah dibuka.

Kelebihan:

-   Sangat ringan dan cepat
-   Setahu saya belum ada alternatifnya, kecuali Kiwix Desktop dan Kiwix Android

Tips teknis:

-   Bisa dengan Docker atau tanpa Docker

Penggunaan kreatif:

-   Untuk melakukan riset mendalam tanpa harus online.

Link penting:

-   [https://github.com/kiwix/kiwix-tools](https://github.com/kiwix/kiwix-tools)
-   [https://github.com/kiwix/kiwix-tools/pkgs/container/kiwix-serve](https://github.com/kiwix/kiwix-tools/pkgs/container/kiwix-serve)

## Calibre Web Automated

Aplikasi manajemen ebook berbasis web self hosted. Saya menggunakan ini sebagai alat untuk manajemen ebook dan sekaligus sebagai alat bacanya.

Fitur-fitur penting:

-   Upload ebook
-   Edit ebook meta data
-   Delete ebook
-   Cari ebook
-   Tag ebook
-   Rate ebook
-   Batch upload ebook (dikenal sebagai ingest)
-   Baca ebook

Kelebihan:

-   Sangat ringan dan cepat
-   Tampilan user friendly
-   Format file yang didukung sangat mencukupi

Tips teknis:

-   Sebaiknya gunakan Docker

Penggunaan kreatif:

-   Untuk melakukan riset mendalam tanpa harus online.

Link penting:

-   [https://github.com/crocodilestick/Calibre-Web-Automated](https://github.com/crocodilestick/Calibre-Web-Automated)

## Ollama

Aplikasi LLM CLI dilengkapi dengan API. Saya menggunakan ini sebagai alternatif ChatGPT.

Fitur-fitur penting:

-   Manajemen model LLM berbasis CLI yang menyerupai docker
-   Mengonversi file gguf menjadi model Ollama
-   Chat dengan CLI
-   Chat berbasis web jika dipadukan dengan Open Webui

Kelebihan:

-   Mudah digunakan
-   API cukup lengkap
-   Instalasi mudah walaupun tanpa docker

Tips teknis:

-   Walaupun bisa digunakan tanpa dedicated GPU, sangat disarankan untuk menggunakan GPU menengah ke atas, seperti Nvidia RTX 2060. Tergantung ukuran model yang digunakan
-   Bisa tanpa Docker

Penggunaan kreatif:

-   Sebagai teman virtual.
-   Kemungkinan bisa digunakan untuk auto blogger (jika platform blog menyediakan API).

Link penting:

-   [https://github.com/ollama/ollama](https://github.com/ollama/ollama)
-   [https://openwebui.com](https://openwebui.com)

## PocketBase

Aplikasi backend self hosted. Saya belum terlalu sering menggunakannya, tapi karena saya bisa menggunakan backend ini untuk website statis saya, saya kira ini cukup berguna.

Fitur-fitur penting:

-   Realtime
-   File storage
-   Authentication
-   Admin dashboard

Kelebihan:

-   Bisa dijadikan backend untuk website statis
-   Menyediakan library untuk manajemen backend-nya
-   Ringan

Tips teknis:

-   Bisa dengan atau tanpa Docker

Penggunaan kreatif:

-   Buat website statis di platform gratisan, kemudian akses backend-nya yang dihosting di rumah.

Link penting:

-   [https://github.com/pocketbase/pocketbase](https://github.com/pocketbase/pocketbase)

## Forgejo

Aplikasi git server self hosted. Saya menggunakan ini untuk menyimpan project percobaan saya. 

Fitur-fitur penting:

-   Kurang lebih mirip dengan GitHub
-   Bisa dihosting di Raspberry Pi

Kelebihan:

-   Ringan
-   Backup dan migrasi mudah

Tips teknis:

-   Bisa dengan atau tanpa Docker

Penggunaan kreatif:

-   Sebagai cadangan repository GitHub dalam perangkat Rarspberry Pi.

Link penting:

-   [https://codeberg.org/forgejo/forgejo](https://codeberg.org/forgejo/forgejo)

## CronMaster

Aplikasi cron self hosted. Saya belum terlalu sering menggunakannya karena baru coba, tapi saya kira ini cukup memudahkan saya mengatur script untuk cron.

Fitur-fitur penting:

-   User interface berbasis web
-   Bisa diinstall di Raspberry Pi
-   Manajemen script yang dijalankan dengan cron

Kelebihan:

-   Karena bisa diinstall di Raspberry Pi, maka saya bisa membiarkannya berjalan dalam hitungan minggu non stop.

Tips teknis:

-   Sebaiknya gunakan Docker

Penggunaan kreatif:

-   Sebagai runner untuk script link scraper atau contact scraper.

Link penting:

-   [https://github.com/fccview/cronmaster](https://github.com/fccview/cronmaster)

## Memos

Aplikasi note taking berbasis web self hosted. Saya menggunakannya untuk code snippets manager.

Fitur-fitur penting:

-   Tag
-   Search
-   Calendar
-   Markdown format per entry
-   Code snippet copy button

Kelebihan:

-   Sangat ringan
-   Mudah diinstall
-   Tampilan sederhana dan tepat guna (bagi saya)

Tips teknis:

-   Sebaiknya gunakan Docker

Penggunaan kreatif:

-   Sebagai code snippet manager

Link penting:

-   [https://github.com/usememos/memos](https://github.com/usememos/memos)

## webtop

Linux distro dalam container. Saya menggunakannya sebagai desktop interface di Ubuntu Server mini pc saya.

Fitur-fitur penting:

-   Berbasis web, bisa dibuka dengan browser
-   Fitur-fitur yang ada pada Linux
-   Memiliki beberapa jenis desktop, misalnya xfce, kde, dan lain-lain
-   Ada versi debian, arch, alpine, dan lain-lain

Kelebihan:

-   Berbasis web, jadi bisa dibuka dengan browser
-   Sangat ringan
-   Pilihan distro dan desktop interface beragam

Tips teknis:

-   Sebaiknya diinstall dengan Docker

Penggunaan kreatif:

-   Sebagai server JDownloader
-   Sebagai browser dalam browser

Link penting:

-   [https://docs.linuxserver.io/images/docker-webtop/](https://docs.linuxserver.io/images/docker-webtop/)

## Penutup

Itulah beberapa aplikasi self hosted yang hingga saat artikel ini ditulis, saya masih menggunakannya.

Saya tidak memberikan cara installnya untuk setiap aplikasi tadi, kecuali Portainer karena cara itu hampir selalu saya gunakan saat menginstallnya, walaupun ada update.

Jika Anda ingin mencari lebih banyak dari daftar tadi, Anda bisa kunjungi:

-   [https://selfh.st/apps/](https://selfh.st/apps/)
-   [https://awesome-selfhosted.net/](https://awesome-selfhosted.net/)
-   [https://docs.linuxserver.io/images-by-category/](https://docs.linuxserver.io/images-by-category/)

Sekian.