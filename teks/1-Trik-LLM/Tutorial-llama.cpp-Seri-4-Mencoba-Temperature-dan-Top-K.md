# Tutorial llama.cpp Seri 4 - Mencoba Temperature dan Top-K

Hari ini saya ingin mencoba pengaruh temperature dan top-k pada llama.cpp.

Model yang digunakan adalah:

ggml-org\_gemma-3-1b-it-GGUF\_gemma-3-1b-it-Q4\_K\_M.gguf

Secara teori, temperature makin tinggi, makin kreatif dan makin rendah makin kaku, begitu pula top-k.

Supaya lebih jelas, saya coba kedua faktor tadi sekaligus.

## Temperature dan Top-K Rendah

Di sini, saya mencoba mengisi temperature senilai 0.00001 dan top-k senilai 1.

Untuk menjalankannya, saya menggunakan perintah ini:

```bash
llama-cli -m ./ggml-org_gemma-3-1b-it-GGUF_gemma-3-1b-it-Q4_K_M.gguf --temp 0.00001 --top-k 1
```

Dengan prompt ini:

```bash
Sebutkan ide-ide aneh untuk menggunakan sendok selain untuk makan.
```

Saya mendapat jawaban ini:

```bash
Oke, ini dia beberapa ide aneh untuk menggunakan sendok selain untuk makan, yang mungkin akan membuatmu terkejut:

**1. Seni & Kerajinan:**

*   **Sculpture:** Gunakan sendok untuk membuat bentuk-bentuk abstrak atau figuratif yang unik. Kamu bisa mencoba membuat "batu" atau "batu bata" yang indah.
*   **Pola:** Buat pola-pola rumit pada permukaan yang halus seperti kaca atau perhiasan.
*   **Penyelesaian Kerajinan:** Gunakan sendok untuk mengoleskan cat, lilin, atau bahan-bahan lain ke permukaan.

**2. Dekorasi & Hiasan:**

*   **Penyelaman:** Gunakan sendok untuk menenggelamkan benda kecil (seperti manik-manik, hiasan, atau bahkan batu) ke dalam cairan.
*   **Penyelaman:** Gunakan sendok untuk menenggelamkan benda kecil ke dalam cairan, lalu gunakan sendok untuk memindahkan cairan tersebut.
*   **Penyelaman:** Gunakan sendok untuk menenggelamkan benda kecil ke dalam cairan, lalu gunakan sendok untuk memindahkan cairan tersebut.
*   **Penyelaman:** Gunakan sendok untuk menenggelamkan benda kecil ke dalam cairan, lalu gunakan sendok untuk memindahkan cairan tersebut.
*   **Penyelaman:** Gunakan sendok untuk menenggelamkan benda kecil ke dalam cairan, lalu gunakan sendok untuk memindahkan cairan tersebut.
*   **Penyelaman:** Gunakan sendok untuk menenggelamkan benda kecil ke dalam cairan, lalu gunakan sendok untuk memindahkan cairan tersebut.

**3. Alat & Eksperimen:**

*   **Penyedot Debu:** Gunakan sendok untuk menyedot debu dari area yang sulit dijangkau.
*   **Penyelamatan:** Gunakan sendok untuk menyelamatkan benda yang jatuh atau terlepas dari tempat yang sulit dijangkau.
*   **Pengukuran:** Gunakan sendok untuk mengukur volume cairan atau benda.
*   **Pengendalian:** Gunakan sendok untuk mengendalikan cairan atau benda yang bergerak.
*   **Penyelamatan:** Gunakan sendok untuk menyelamatkan benda yang terlepas dari tempat yang sulit dijangkau.

**4. Aktivitas Kreatif & Lucu:**

*   **Penyelaman:** Gunakan sendok untuk menenggelamkan benda kecil ke dalam cairan, lalu gunakan sendok untuk memindahkan cairan tersebut.
*   **Penyelaman:** Gunakan sendok untuk menenggelamkan benda kecil ke dalam cairan, lalu gunakan sendok untuk memindahkan cairan tersebut.
*   **Penyelaman:** Gunakan sendok untuk menenggelamkan benda kecil ke dalam cairan, lalu gunakan sendok untuk memindahkan cairan tersebut.
*   **Penyelaman:** Gunakan sendok untuk menenggelamkan benda kecil ke dalam cairan, lalu gunakan sendok untuk memindahkan cairan tersebut.
*   **Penyelaman:** Gunakan sendok untuk menenggelamkan benda kecil ke dalam cairan, lalu gunakan sendok untuk memindahkan cairan tersebut.

**5.  Kegiatan Lainnya:**

*   **Membuat Bentuk:** Gunakan sendok untuk membuat bentuk-bentuk yang rumit dan unik.
*   **Menggali:** Gunakan sendok untuk menggali lubang kecil di tanah atau pasir.
*   **Membuat Kerangka:** Gunakan sendok untuk membuat kerangka sederhana untuk benda-benda kecil.

**Penting:**  Pastikan kamu menggunakan sendok dengan hati-hati dan hanya untuk tujuan kreatif atau eksperimen.

Semoga ide-ide ini menginspirasi!  Apakah kamu ingin ide-ide yang lebih spesifik, misalnya, untuk jenis benda tertentu (misalnya, makanan, batu, atau tanaman)?
```

## Temperature dan Top-K Tinggi

Di sini, saya mencoba mengisi temperature senilai 0.99 dan top-k senilai 100.

Untuk menjalankannya, saya menggunakan perintah ini:

```bash
llama-cli -m ./ggml-org_gemma-3-1b-it-GGUF_gemma-3-1b-it-Q4_K_M.gguf --temp 0.99 --top-k 100
```

Dengan prompt ini:

```bash
Sebutkan ide-ide aneh untuk menggunakan sendok selain untuk makan.
```

Jawabannya:

```bash
Oke, ini beberapa ide aneh untuk menggunakan sendok selain untuk makan:

**Kreatif & Artistik:**

1.  **Melukis dengan Sendok:** Gunakan sendok sebagai alat untuk melukis dengan warna-warna yang berbeda, menciptakan gradasi atau efek visual.
2.  **Sculpting dengan Sendok:**  Buat bentuk-bentuk kecil atau detail-detail lucu dengan sendok.
3.  **Menggambar dengan Sendok:**  Buat sketsa atau gambar sederhana dengan sendok sebagai alat.
4.  **Membuat Hiasan:** Gunakan sendok untuk membuat hiasan seperti motif atau gambar kecil.
5.  **Menyusun Bentuk-Bentuk:** Gunakan sendok untuk menyusun bentuk-bentuk atau pola di atas permukaan.

**Lucu & Eksperimental:**

6.  **Sendok Hantu:**  Buat sendok hantu dengan cat atau stiker untuk tampilan yang lucu.
7.  **Sendok Berbicara:**  Gunakan sendok sebagai "kata" untuk berkomunikasi. (Mungkin dengan sentuhan suara kecil atau gerakan).
8.  **Sendok Membaca:**  Gunakan sendok sebagai "buku" untuk membaca.
9.  **Sendok Mengumpulkan Koin:**  Buat sendok dengan hiasan atau desain untuk mengumpulkan koin.
10. **Sendok 'Berjalan'**:  Gunakan sendok untuk menari atau bergerak di atas permukaan.

**Praktis & Tidak Biasa:**

11. **Membuat Bentuk-Bentuk:** Gunakan sendok untuk membuat bentuk-bentuk tertentu, seperti lingkaran atau segitiga, untuk dekorasi.
12. **Memasukkan Koin:** Gunakan sendok untuk memasukkan koin ke dalam benda-benda kecil.
13. **Memperbaiki Sesuatu:** Gunakan sendok untuk memperbaiki benda-benda kecil atau membuat perbaikan ringan.
14. **Menghasilkan 'Hujan'**:  Gunakan sendok untuk memanipulasi sedikit cairan.
15. **Penguji Sentuhan:**  Gunakan sendok untuk mengecek tekstur suatu benda.

**Penting:**  Pastikan Anda menggunakan sendok dengan aman dan tidak merusak benda-benda di sekitarnya!

Semoga ide-ide ini membuat Anda berpikir di luar kotak!  Apakah kamu ingin ide yang lebih spesifik, misalnya yang untuk anak-anak atau untuk kegiatan tertentu?
```

## Komentar Saya

😅 Entah kenapa, dua-duanya serupa.