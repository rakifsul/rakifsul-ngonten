# Cara Build Ollama dari Source Code dan Mencoba Menjalankannya

Hari itu saya bangun sekitar jam 9.30 malam 👻. Saat itu matahari belum terlihat.

Karena tak lama setelah bangun saya baru saja memindahkan backup storage saya ke SSD yang lain, saya jadi bisa memanfaatkan SSD SATA dengan enclosure itu kembali ke PC AI saya.

Wajar, karena selama ini PC AI saya menggunakan SSD bawaannya yang tidak terlalu besar kapasitasnya.

Rencananya, saya ingin sekali mem-pull beberapa model Ollama yang sekitaran 7b parameter.

Tujuannya adalah untuk mencari tahu mana yang paling cocok untuk kegiatan coding saya.

Langsung saya install Ubuntu Server 24.04.3 di PC saya beserta driver NVidia-nya.

Selepas itu, saya mendownload beberapa model hingga akhirnya saya bosan.

Saya memutuskan untuk sedikit ganti suasana dengan melihat-lihat repository Ollama.

Beberapa info tentang Ollama memang belum saya ketahui dan baru saya sadari saat itu.

Salah satunya adalah tentang penggunaan Modelfile yang mirip dengan Dockerfile-nya Docker.

Selain itu, saya juga baru tahu bagaimana cara mem-build Ollama dari source code-nya tanpa Docker.

Karena saya tertarik untuk melakukan eksplorasi lebih lanjut, saya memulainya dengan mencoba membuild Ollama dari source code tanpa Docker.

Nanti Anda akan lihat bagaimana Ollama dijalankan di lingkungan development sebagai perintah bahasa go.

Ok, sekarang kita lanjut...

## Persiapan

Sebelum Anda mem-build Ollama, lakukan ini:

1.  Download go [dari website resminya](https://go.dev/dl/), ekstrak, kemudian set $PATH ke binaries-nya agar bisa dijalankan dari folder manapun.
2.  Install build-essential ( sudo apt install build-essential ).
3.  Install cmake ( sudo apt install cmake )
4.  clone repository Ollama ( git clone https://github.com/ollama/ollama.git )

## Melakukan Build

Masuklah ke dalam folder repository ollama yang telah kita clone tadi:

```bash
cd ollama
```

Lalu configure dan build:

```bash
cmake -B build
cmake --build build
```

Ini akan sedikit lama di PC saya.

Setelah berhasil, kita siap menjalankannya, tapi bukan dengan perintah ./ollama melainkan dengan perintah go.

## Mencoba Menjalankan Ollama Hasil Build

Saat Anda ingin menjalankan Ollama hasil build, Anda perlu 1 session terminal yang dibiarkan berjalan, karena kita ingin service dari Ollama tersebut jalan terus.

Jadi, buka 1 terminal, kemudian jalankan perintah ini:

```bash
go run . serve
```

Biarkan tetap terbuka, kemudian buka 1 terminal yang lain dan jalankan:

```bash
go run . run gemma3:1b
```

Itu akan mem-pull model gemma3:1b kemudian dilanjutkan dengan chat.

## Penutup

Jika Anda ingin perintah tadi bisa dijalankan dari folder manapun, **mungkin**:

-   Anda bisa masukkan perintah tersebut ke dalam script bash,
-   beri permission untuk menjalankannya dengan chmod +x (silakan cari sendiri),
-   kemudian Anda tambahkan lokasi script tersebut di PATH.

**Saya belum coba itu**. Jadi saya **tidak tahu apakah akan berhasil atau tidak**. Silakan coba sendiri.

Yang jelas, **jika Anda tidak ingin menggunakan versi source code-nya**, Anda bisa langsung install aplikasinya melalui [website resminya](https://ollama.com/download).