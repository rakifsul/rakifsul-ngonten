# Cara Install Qemu KVM di Ubuntu

Qemu merupakan aplikasi yang dapat menjalankan OS di dalam OS.

OS yang menjalankan OS disebut Host, sedangkan yang dijalankan tadi disebut Guest.

Qemu banyak gunanya, di antaranya adalah untuk mencoba Arch Linux tanpa harus install ke komputer langsung maupun dengan dual boot.

Berikut ini adalah langkah yang saya gunakan untuk menginsall Qemu KVM.

## 1. Mengecek Kemampuan Virtualisasi

Cara untuk mengecek virtualisasi di komputer Anda:

```
# parameter -E dan sebelahnya menandai adanya extended RegEx.

lscpu | grep -E 'vmx|svm'
```

Jika outputnya mengandung kata "vmx" atau "svm", maka komputer Anda mendukung virtualiasi.

Kemungkinan hasilnya "vmx" jika Anda gunakan CPU intel, dan "svm" jika Anda gunakan CPU AMD.

Jika hasilnya negatif, silakan coba enable di BIOS.

Jika di BIOS tidak ada settingan untuk virtualisasi, mungkin saja komputer Anda tidak memiliki fitur tersebut.

## 2. Menginstall Qemu KVM dan Package yang Dibutuhkan

Caranya:

```
sudo apt update

# parameter -y akan menjawab yes untuk setiap pertanyaan yang muncul saat install package.

sudo apt install -y libvirt-clients libvirt-daemon-system bridge-utils qemu-kvm virt-manager
```

## 3. Mengecek Status KVM Setelah diinstall

Caranya:

```
sudo systemctl status libvirtd
```

Seharusnya Anda melihat statusnya running.

```
lsmod | grep kvm
```

Seharusnya menampilkan "kvm" dan "kvm_intel" jika Anda menggunakan CPU Intel atau "kvm" dan "kvm_amd" jika Anda menggunakan CPU AMD.

## 4. Menambahkan $USER ke Group kvm dan libvirt

```
sudo usermod -aG kvm,libvirt $USER
```

Selanjutnya, reboot komputer Anda.

## Penutup

Setelah itu Anda bisa menggunakan perintah untuk manajemen VM tanpa sudo.

Walaupun begitu, ingat bahwa kita telah menginstall aplikasi manajemen Qemu dalam bentuk GUI juga.

Anda bisa cek di daftar aplikasi Ubuntu Anda. Cari yang namanya "Virtual Machine Manager".