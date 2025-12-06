# Memperbaiki Setting LM Studio agar Bisa Jalan Lagi

Beberapa waktu yang lalu saya telah menginstall LM Studio.

Walaupun saya menggunakan mini pc dengan RAM 32GB dan CPU 6 core dan 8 thread, aplikasi tersebut berjalan cukup lancar untuk LLM dengan 1B parameter.

Namun, kisah ini tidak selesai di sini.

Karena saya memang tertarik untuk mengoprek aplikasi LLM, saya juga mencoba untuk menginstall dan mempelajari llama.cpp.

Setelah mencoba memahami struktur file dan foldernya, saya mencoba untuk membuat version manager-nya sendiri.

Dengan kata lain, waktu itu saya membuat llama.cpp version manager.

Namun, setelah beberapa waktu ke depan, saat saya membuka LM Studio dan menjalankan salah satu model favorit saya, aplikasi tersebut gagal memuat model dan memunculkan popup berisi error message dengan exit code: null.

Saya tidak mengerti di mana permasalahannya.

Saya mencoba mengganti setting hardware di LM Studio, namun error tersebut tetap muncul.

Kemudian, saya mengganti engine-nya agar hanya pakai CPU, namun error masih muncul.

Akhirnya, setelah saya paham, saya menyimpulkan bahwa error tersebut disebabkan oleh aplikasi llama.cpp version manager yang telah saya ceritakan tadi.

Aplikasi version manager tadi membutuhkan penambahan PATH pada lokasi version manager yang telah saya ceritakan tadi.

Sepertinya, mungkin, di dalam kode dari LM Studio, llama.cpp yang dipanggil adalah llama.cpp dari aplikasi llama.cpp version manager saya dan mungkin itu tidak kompatibel dengan LM Studio.

Saya mencoba memastikan itu dengan mendisable PATH dari llama.cpp version manager saya, kemudian mencoba memuat model lagi dengan LM Studio, dan ternyata berhasil.

Sepertinya, saya juga telah melihat laporan error yang serupa di suatu tempat. Mungkin kejadiannya serupa dengan yang saya alami.

Pelajaran dari kejadian ini adalah:

- sebaiknya, saat kita membuat aplikasi yang perlu memanggil aplikasi lain dari suatu PATH atau yang semacam itu, sebaiknya kita gunakan absolute path dari aplikasi yang dipanggil tersebut.

Bagaimana menurut Anda?

