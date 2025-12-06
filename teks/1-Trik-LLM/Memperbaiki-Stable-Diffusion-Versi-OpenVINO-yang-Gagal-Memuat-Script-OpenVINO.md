# Memperbaiki Stable Diffusion Versi OpenVINO yang Gagal Memuat Script OpenVINO

Semalaman tadi, saya memikirkan cara yang paling tepat mengatasi RAM nganggur di Mini PC saya.

Walaupun saya sudah install aplikasi cukup banyak, bahkan Ollama sekalipun, namun  tampaknya RAM saya masih saja kurang terpakai. Padahal, konon katanya, RAM yang tak terpakai sebenarnya adalah resource yang terbuang.

Saya ingat, tentunya, bahwa saya pernah bilang bahwa saya paling suka jika resource hardware yang terpakai oleh saya seminim mungkin saat menjalankan program yang berat.

Walaupun begitu, itu bukan berarti saya tidak pernah berubah-ubah pikiran. Semalam tadi saya tiba-tiba ingin menginstall aplikasi yang sedikit membuat hardware saya terbebani.

Apalagi, saya juga ingin mengetahui limit dari kemampuan hardware mini pc saya.

Setelah beberapa menit, tiba-tiba saya teringat sebuah program yang mampu menggenerate gambar dari prompt. Namanya Stable Diffusion dari AUTOMATIC1111 dan saya ingat bahwa saya pernah melihat fork-nya yang menggunakan OpenVINO.

Dulu memang saya pernah menginstall Stable Diffusion versi OpenVINO-nya. Saya sendiri kurang tahu tentang OpenVINO, tapi memang itu bisa membuat Stable Diffusion berjalan lebih cepat dengan mengandalkan CPU.

## Kemudian Saya Menginstallnya dengan Cara Biasa

Langsung saya clone Stable Diffusion versi OpenVINO dengan cara ini:

```bash
 git clone https://github.com/openvinotoolkit/stable-diffusion-webui.git
```

Kemudian, dengan pyenv, saya install Python 3.10.x:

```bash
pyenv install 3.10
```

Karena saya dapat Python versi 3.10.18 dari perintah tadi, maka saya aktifkan versi tersebut:

```bash
pyenv global 3.10.18
```

Akibatnya, perintah python --version menunjukkan versi 3.10.18.

Berdasarkan cara wajar menginstall Stable Diffusion versi OpenVINO, Saya mengganti isi dari ./webui-user.sh menjadi seperti ini:

```bash
# .. script sebelum baris ini
# Commandline arguments for webui.py, for example: export COMMANDLINE_ARGS="--medvram --opt-split-attention"
export COMMANDLINE_ARGS="--skip-torch-cuda-test --precision full --no-half"

# python3 executable
python_cmd="/home/username-saya/.pyenv/versions/3.10.18/bin/python"
# ... script setelah baris ini
```

Kemudian saya tambahkan --listen dan --port 10000 agar bisa diekspos ke 0.0.0.0:10000:

```bash
# ... script sebelum baris ini
# Commandline arguments for webui.py, for example: export COMMANDLINE_ARGS="--medvram --opt-split-attention"
export COMMANDLINE_ARGS="--skip-torch-cuda-test --precision full --no-half --listen --port 10000"

# python3 executable
python_cmd="/home/username-saya/.pyenv/versions/3.10.18/bin/python"
# ... script sesudah baris ini
```

Lalu saya jalankan dengan:

```bash
./webui.sh
```

Saya tunggu sampai proses inisialisasi selesai dan saya buka http://127.0.0.1:10000

Halamannya tampil, tapi pilihan script "Accelerate with OpenVINO" tidak muncul.

Pasti ada yang salah...

## Solusi yang Saya Dapatkan

Saya berulang kali menebak apa yang error, namun belum berhasil.

ChatGPT bahkan menyarankan saya mengubah kode Python-nya 😅...

Sampai saya menemukan diskusi ini di repository-nya:

[https://github.com/openvinotoolkit/stable-diffusion-webui/issues/81#issuecomment-1826904972](https://github.com/openvinotoolkit/stable-diffusion-webui/issues/81#issuecomment-1826904972)

Dan menemukan diskusi ini di tempat lain:

[https://community.intel.com/t5/Intel-Distribution-of-OpenVINO/openvino-not-working/td-p/1666352](https://community.intel.com/t5/Intel-Distribution-of-OpenVINO/openvino-not-working/td-p/1666352)

Yang akhirnya saya simpulkan bahwa saya harus mengubah ./requirements\_versions.txt menjadi seperti ini:

```bash
# .. script sebelum baris ini
huggingface_hub==0.20.2
torch==2.1.0
torchvision==0.16.0
# ... script setelah baris ini
```

Tadinya, di ./requirements\_versions.txt tidak ada detail versi pada torch, dan tidak ada huggingface\_hub dan tidak ada torchvision.

Saya tidak mengerti tentang 2 dependencies terakhir tadi, tapi yang saya tahu, jika torch diinstall tanpa detail versi maka versi terbaru yang akan diambil.

Dengan menggunakan torch versi terbaru saat ini untuk Stable Diffussion yang terakhir dicommit setahun yang lalu, saya tidak heran bahwa bugs akan muncul.

Selain itu, saya juga mengubah ./webui-user.sh menjadi:

```bash
# ... script sebelum baris ini
# BUGFIX
export USE_OPENVINO=1

# Commandline arguments for webui.py, for example: export COMMANDLINE_ARGS="--medvram --opt-split-attention"
export COMMANDLINE_ARGS="--skip-torch-cuda-test --precision full --no-half --listen --port 10000"

# python3 executable
python_cmd="/home/username-saya/.pyenv/versions/3.10.18/bin/python"
# ... script sesudah baris ini
```

Setelah saya melakukan pip install -r requirements\_versions.txt, akhirnya dependencies tadi di-update dan ./webui.sh berjalan dengan benar.

Saya coba beberapa kali generate gambar, memang dengan OpenVINO sedikit lebih cepat. Silakan Anda coba sendiri dan perhatikan terminal outputnya.

## Penutup

Banyak pelajaran yang bisa kita ambil dari kejadian ini:

-   Pelajaran teknis yang saya bahas barusan.
-   Bahwa LLM tidak selalu bisa menjawab pertanyaan kita, terutama yang memerlukan presisi tinggi, sambil sekaligus tetap akurat.
-   Website dan Blog masih diperlukan.

## Bonus: Gallery

<p align="center">
    <img src="../../media/Screenshot_20250907_092942.png?raw=true" alt="tampilan"/>
</p>