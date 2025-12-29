# Daftar Aplikasi CLI yang Harus Anda Coba di Tahun 2025

## htop

Aplikasi ini berguna untuk memantau penggunaan resource di komputer Linux Anda.

Secara default, htop menampilkan penggunaan CPU tiap core-nya dan penggunaan Memory.

Walaupun begitu, Anda juga bisa menambahkan tampilan data penggunaan resource lainnya dengan mudah.

Cara install:

```
sudo apt install htop
```

Cara menjalankan:

```
htop
```

## btop

Aplikasi ini masih serupa dengan htop, tapi dengan tampilan yang lebih menarik.

Selain itu, btop secara default menampilkan suhu tiap core dari CPU.

Cara install:

```
sudo snap install btop
```

Cara menjalankan:

```
btop
```

## Midnight Commander

Anda punya server Ubuntu? Tanpa GUI? Tapi ingin melakukan manajemen file dengan mudah?

Anda bisa coba Midnight Commander.

Aplikasi tersebut memungkinkan pengguna untuk melakukan manajemen file dengan GUI di terminal.

Cara install:

```
sudo apt install mc
```

Cara menjalankan:

```
mc
```

## micro

Anda ingin mengedit file teks dengan terminal tapi kurang cocok dengan nano dan vi?

micro mungkin menjadi pilihan alternatif Anda.

Aplikasi tersebut memiliki keybinding yang serupa dengan text editor berbasis GUI pada umumnya.

Jadi, Anda bisa menggunakan ctrl c, ctrl v, ctrl x dan lain-lain dengan text editor ini.

Cara install:

```
sudo apt install micro
```

Cara menjalankan:

```
micro
```

## Ollama

Ollama adalah sebuah aplikasi LLM yang bisa menjalankan model secara offline.

Dalam mendapatkan modelnya, kita bisa menggunakan repository-nya atau dengan melakukan konversi dari model GGUF yang telah kita download sebelumnya.

Perintah pada Ollama menyerupai docker. Jadi jangan heran ada perintah seperti ollama run, ollama stop, dan ollama ps.

Cara install:

```
# buka website resminya di:

# https://ollama.com

# kemudian install sesuai instruksi di sana
```

Cara menjalankan:

```
ollama run nama_model
```

## llama.cpp

Jika Anda ingin menjalankan LLM lokal di komputer yang tidak terlalu powerful, Anda bisa pertimbangkan untuk menggunakan llama.cpp.

Di paket dari llama.cpp, terdapat aplikasi llama-cli yang bisa menjalankan model LLM dari terminal.

Selain itu, masih banyak lagi aplikasi-aplikasi pendukungnya di dalam paket aplikasi llama.cpp tersebut.

Cara install:

```
# buka repository-nya di:

# https://github.com/ggml-org/llama.cpp

# buka halaman Releases dan download sesuai OS yang Anda gunakan.

# masukkan directory binaries dari llama.cpp ke daftar PATH dan LD_LIBRARY_PATH
```

Cara menjalankan:

```
llama-cli -m nama_model.gguf
```

## git

Mungkin Anda tidak setuju dengan ini, tapi saya rasa di tahun 2025, sebaiknya pengguna linux tahu cara install aplikasi linux dari source code, meskipun bukan seorang developer.

Karena sebagian besar dari source code di-host dengan git, maka sebaiknya Anda mulai belajar menggunakan git.

Tidak harus yang susah-susah dulu. Cukup git clone, git pull, git add, git commit, dan git push.

Walaupun demikian, sebenarnya git saja tidak cukup, karena cara build aplikasi dari source code berbeda-beda.

Tapi tenang saja. Pada umumnya source code aplikasi terkenal yang menerapkan git memiliki informasi yang cukup jelas tentang bagaimana cara melakukan build atau install aplikasinya dari source code.

Cara install:

```
# biasanya sudah termasuk dalam paket instalasi Ubuntu

# tapi kalau belum, Anda hanya perlu jalankan:

sudo apt install git
```

## yt-dlp

Jika Anda suka nonton YouTube dan ingin mendownload video-nya, Anda bisa pakai yt-dlp.

Cara install:

```
# kunjungi repository-nya di:

# https://github.com/yt-dlp/yt-dlp

# kemudian buka halaman Releases dan download yang sesuai dengan OS Anda

# pastikan lokasi di mana Anda meletakkan yt-dlp sudah termasuk dalam daftar PATH
```

Cara menjalankan:

```
yt-dlp URL-Video-YouTube
```

## Penutup

Itulah beberapa aplikasi CLI yang saya rekomendasikan untuk Anda coba. Mungkin ada yang terlupakan oleh saya.

Jadi, ada baiknya jika Anda coba mencari aplikasi lainnya yang cocok dengan kebutuhan Anda.

Jika Anda ingin melakukan itu, saran saya coba search dengan keyword "awesome cli" atau yang semacamnya.