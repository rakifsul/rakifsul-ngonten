# Cara Install ComfyUI dengan pyenv di Ubuntu

[ComfyUI](https://github.com/comfyanonymous/ComfyUI) adalah aplikasi yang salah satu fungsinya adalah untuk menggenerate gambar dengan tampilan berupa kumpulan node yang terhubung satu sama lain.

Aplikasi ini dapat dijalankan pada komputer dengan dedicated GPU ataupun tanpa dedicated GPU.

Dengan kata lain bisa dijalankan di mini PC saya, yakni Cubi 5 12 M, meskipun CPU saya hanya memiliki 6 core dan 8 thread.

Namun, jika Anda memiliki PC seperti saya tadi, setidaknya gunakan RAM yang cukup besar. Dalam hal ini, saya menggunakan RAM 32 GB.

Di artikel ini, saya akan membahas cara install ComfyUI baik di PC yang ada dedicated GPU-nya, maupun yang tidak.

Hanya saja, saya membatasi pembahasan untuk PC dengan dedicated GPU pada GPU NVidia RTX 2060 Super 8 GB VRAM.

Ingin tahu lebih lanjut? Terus baca...

## Menginstall pyenv dan python 3.13

Jika Anda belum menginstall python, maka sebelum Anda menginstallnya, lebih baik gunakan pyenv.

Itu karena pyenv adalah version manager untuk python.

Dengan version manager, maka Anda dapat menginstall berbagai versi python dan dapat berpindah-pindah versi dengan mudah.

Cara menginstall pyenv ada di repository-nya.

Daripada saya bahas di sini, lebih baik Anda pelajari sendiri [di sini](https://github.com/pyenv/pyenv).

Namun, pesan saya, jangan lewatkan untuk membaca bagian penginstallan [python build dependencies-nya](https://github.com/pyenv/pyenv?tab=readme-ov-file#d-install-python-build-dependencies), karena pyenv tidak mendownload versi binary dari python, melainkan dengan mendownload source codenya dan membuildnya di komputer Anda.

Setelah Anda selesai menginstall pyenv sesuai instruksinya, jalankan ini di terminal Anda:

```
pyenv install 3.13
```

Selanjutnya, perhatikan versi lengkap dari python tersebut.

Caranya dengan melihat daftar python yang telah terinstall:

```
pyenv versions
```

Catat dan ingat baik-baik versi lengkap python tersebut.

Saya **misalkan** sebagai versi 3.13.7 untuk mempermudah tutorial ini.

## Menginstall ComfyUI di PC tanpa Dedicated GPU

Saya hanya membahas caranya di Ubuntu Desktop 24.04.

Kondisi PC saya:

- CPU: Intel® Core™ i3-1215U
- RAM: 32 GB
- SSD: 1 TB
- OS: Ubuntu Desktop 24.04

Pertama masuklah ke folder manapun yang merupakan hak milik dari user ubuntu Anda saat Anda gunakan.

Sebagai contoh, saya menempatkannya di:

/home/username/Apps/ComfyUI

Masuklah ke folder tersebut:

```
cd /home/username/Apps/ComfyUI
```

Selanjutnya, clone ComfyUI dari repository-nya:

```
git clone https://github.com/comfyanonymous/ComfyUI.git
```

Lalu masuk ke folder repository-nya:

```
cd ComfyUI
```

Selanjutnya jalankan ini:

```
pip install -r requirements.txt
```

Terakhir, Anda bisa menjalankan ComfyUI dengan perintah ini:

```
cd /home/username/Apps/ComfyUI/ComfyUI

pyenv local 3.13.7

# option --cpu digunakan untuk menjamin bahwa ComfyUI menggunakan CPU untuk komputasinya.
python main.py --cpu
```

Dengan cara itu, Anda hanya bisa mengaksesnya dari komputer lokal Anda saja.

Yakni di alamat ini: 

http://127.0.0.1:8188

Jika Anda ingin expose ComfyUI di lokal network Anda, maka perintahnya menjadi:

```
python main.py --cpu --listen 0.0.0.0
```

Sekarang alamatnya jadi: 

http://ip-komputer-desktop-anda:8188

## Menginstall di PC dengan GPU NVidia

Saya hanya membahas caranya di Ubuntu Server 24.04 dan saya berasumsi bahwa driver NVidia Anda sudah terinstall.

Kondisi PC saya:

- CPU: Intel® Core™ i5 generasi 3
- RAM: 16 GB
- SSD: 1 TB
- OS: Ubuntu Server 24.04
- Driver NVidia sudah terinstall

Pertama masuklah ke folder manapun yang merupakan hak milik dari user ubuntu Anda saat Anda gunakan.

Sebagai contoh, saya menempatkannya di:

/home/username/Apps/ComfyUI

Masuklah ke folder tersebut:

```
cd /home/username/Apps/ComfyUI
```

Selanjutnya, clone ComfyUI dari repository-nya:

```
git clone https://github.com/comfyanonymous/ComfyUI.git
```

Lalu masuk ke folder repository-nya:

```
cd ComfyUI
```

Selanjutnya jalankan ini:

```
pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu130

pip install -r requirements.txt
```

Terakhir, Anda bisa menjalankan ComfyUI dengan perintah ini:

```
cd /home/username/Apps/ComfyUI/ComfyUI

pyenv local 3.13.7

# karena ini server, maka saya buat dapat diakses dari ip luar dengan menambahkan --listen 0.0.0.0
# karena pc ini menggunakan dedicated GPU, maka saya tidak menggunakan option --cpu
python main.py --listen 0.0.0.0
```

Dengan cara itu, Anda bisa mengaksesnya dari komputer di network Anda.

Yakni di alamat ini: http://ip-server-anda:8188

## Penutup

Karena aplikasi ini berbasis web dan dijalankan dari command line, maka sebaiknya Anda membuat script bash untuk mempermudah menjalankannya.

Saya beri sedikit contoh script tersebut di bawah ini:

```
#!/bin/bash

# contoh script runner untuk versi dedicated GPU

cd /home/username/Apps/ComfyUI/ComfyUI

pyenv local 3.13.7

python --version

python main.py --listen 0.0.0.0
```

Bagaimana? Mudah, bukan?