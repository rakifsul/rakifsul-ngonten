# Membandingkan Hasil Benchmark Dua Nilai Batch Size pada Penggunaan llama-bench dari llama.cpp

Sebelumnya, saya telah mendapat sedikit info tentang llama.cpp bahwa llama.cpp bisa berjalan di hardware terbatas.

Oleh karena itu, saya akan menggunakan [llama.cpp](https://github.com/ggml-org/llama.cpp) untuk percobaan kali ini.

Saya ingin tahu bagaimana mini pc saya merespon nilai batch size yang berbeda jika saya menggunakan llama-bench dari llama.cpp. Masing-masing nilai batch size diterapkan pada 2 cpu mode: powersave dan performance.

## Spesifikasi Hardware dan Software

Sebagai info, mini pc saya memiliki spesifikasi ini:

-   OS: Ubuntu Server 24.04.3
-   CPU: Intel® Core™ i3-1215U
-   Graphics: Intel® UHD Graphics (Core i3)
-   RAM: 16 GB DDR4 2666/ 3200MHz SO-DIMMs
-   Storage: M.2 SSD (NVMe PCIe Gen4 x4 / SATA auto switch)
-   llama.cpp build: e8215dbb (5760)

## Model yang Digunakan

Model yang akan digunakan adalah gemma-3-it-4B-Q4\_K\_M.gguf dari Hugging Face. Saya lupa link-nya dan tidak tercatat.

## Kondisi 1: CPU Mode: powersave

Saya menerapkan cpu mode di "powersave" secara default. Untuk mengeceknya, saya gunakan perintah ini:

```bash
grep . /sys/devices/system/cpu/cpu[0-7]/cpufreq/scaling_governor
```

Ini outputnya:

```bash
/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor:powersave
/sys/devices/system/cpu/cpu1/cpufreq/scaling_governor:powersave
/sys/devices/system/cpu/cpu2/cpufreq/scaling_governor:powersave
/sys/devices/system/cpu/cpu3/cpufreq/scaling_governor:powersave
/sys/devices/system/cpu/cpu4/cpufreq/scaling_governor:powersave
/sys/devices/system/cpu/cpu5/cpufreq/scaling_governor:powersave
/sys/devices/system/cpu/cpu6/cpufreq/scaling_governor:powersave
/sys/devices/system/cpu/cpu7/cpufreq/scaling_governor:powersave
```

## Kondisi 2: CPU Mode: performance

Kita bisa mengganti cpu mode ke performance dengan perintah ini:

```bash
sudo cpupower frequency-set -g performance
```

Nanti, setelah kondisi 1 dicoba, saya akan menjalankan perintah tadi untuk melihat efeknya.

## Perintah yang Digunakan

Di percobaan ini, saya punya dua command llama-bench yang berbeda.

Perbedaannya terletak pada batch size yang digunakan:

```bash
# perintah 1
llama-bench -m ./gemma-3-it-4B-Q4_K_M.gguf -p 512 -n 128 --batch-size 64

# perintah 2
llama-bench -m ./gemma-3-it-4B-Q4_K_M.gguf -p 512 -n 128 --batch-size 512
```

Parameter -p 512 berarti jumlah token input (panjang teks yang diberikan ke model untuk “dibaca” pada tahap prefill).

Parameter -n 128 berarti model diminta menghasilkan 128 token baru.

Nanti kedua perintah tersebut akan diterapkan ke masing-masing cpu mode.

## Percobaan Dilakukan

### Kondisi 1: CPU Mode: powersave

Perintah 1:

```bash
llama-bench -m ./gemma-3-it-4B-Q4_K_M.gguf -p 512 -n 128 --batch-size 64
```

Copy

Memberikan hasil ini:

```bash
load_backend: loaded RPC backend from /home/username-saya/Documents/Project/0-llama-cpp/libggml-rpc.so
load_backend: loaded CPU backend from /home/username-saya/Documents/Project/0-llama-cpp/libggml-cpu-alderlake.so
| model                          |       size |     params | backend    | ngl | n_batch |            test |                  t/s |
| ------------------------------ | ---------: | ---------: | ---------- | --: | ------: | --------------: | -------------------: |
| gemma3 4B Q4_K - Medium        |   2.31 GiB |     3.88 B | RPC        |  99 |      64 |           pp512 |         24.84 ± 0.48 |
| gemma3 4B Q4_K - Medium        |   2.31 GiB |     3.88 B | RPC        |  99 |      64 |           tg128 |          9.70 ± 0.07 |

build: e8215dbb (5760)

```

Perintah 2:

```bash
llama-bench -m ./gemma-3-it-4B-Q4_K_M.gguf -p 512 -n 128 --batch-size 512
```

Memberikan hasil ini:

```bash
load_backend: loaded RPC backend from /home/username-saya/Documents/Project/0-llama-cpp/libggml-rpc.so
load_backend: loaded CPU backend from /home/username-saya/Documents/Project/0-llama-cpp/libggml-cpu-alderlake.so
| model                          |       size |     params | backend    | ngl | n_batch |            test |                  t/s |
| ------------------------------ | ---------: | ---------: | ---------- | --: | ------: | --------------: | -------------------: |
| gemma3 4B Q4_K - Medium        |   2.31 GiB |     3.88 B | RPC        |  99 |     512 |           pp512 |         25.25 ± 0.70 |
| gemma3 4B Q4_K - Medium        |   2.31 GiB |     3.88 B | RPC        |  99 |     512 |           tg128 |          9.72 ± 0.07 |

build: e8215dbb (5760)
```

### Kondisi 2: CPU Mode: performance

Di kondisi ini, saya menjalankan perintah ini sebelum melakukan benchmark:

```bash
sudo cpupower frequency-set -g performance
```

Untuk mengecek ulang cpu mode-nya, saya beri perintah ini:

```bash
grep . /sys/devices/system/cpu/cpu[0-7]/cpufreq/scaling_governor
```

Output-nya seperti ini:

```bash
/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor:performance
/sys/devices/system/cpu/cpu1/cpufreq/scaling_governor:performance
/sys/devices/system/cpu/cpu2/cpufreq/scaling_governor:performance
/sys/devices/system/cpu/cpu3/cpufreq/scaling_governor:performance
/sys/devices/system/cpu/cpu4/cpufreq/scaling_governor:performance
/sys/devices/system/cpu/cpu5/cpufreq/scaling_governor:performance
/sys/devices/system/cpu/cpu6/cpufreq/scaling_governor:performance
/sys/devices/system/cpu/cpu7/cpufreq/scaling_governor:performance
```

Kemudian saya jalankan perintah-perintah ini dari terminal.

Perintah 1:

```bash
llama-bench -m ./gemma-3-it-4B-Q4_K_M.gguf -p 512 -n 128 --batch-size 64
```

Memberikan hasil ini:

```bash
load_backend: loaded RPC backend from /home/username-saya/Documents/Project/0-llama-cpp/libggml-rpc.so
load_backend: loaded CPU backend from /home/username-saya/Documents/Project/0-llama-cpp/libggml-cpu-alderlake.so
| model                          |       size |     params | backend    | ngl | n_batch |            test |                  t/s |
| ------------------------------ | ---------: | ---------: | ---------- | --: | ------: | --------------: | -------------------: |
| gemma3 4B Q4_K - Medium        |   2.31 GiB |     3.88 B | RPC        |  99 |      64 |           pp512 |         26.07 ± 1.07 |
| gemma3 4B Q4_K - Medium        |   2.31 GiB |     3.88 B | RPC        |  99 |      64 |           tg128 |          9.06 ± 0.01 |

build: e8215dbb (5760)
```

Perintah 2:

```bash
llama-bench -m ./gemma-3-it-4B-Q4_K_M.gguf -p 512 -n 128 --batch-size 512
```

Memberikan hasil ini:

```bash
load_backend: loaded RPC backend from /home/username-saya/Documents/Project/0-llama-cpp/libggml-rpc.so
load_backend: loaded CPU backend from /home/username-saya/Documents/Project/0-llama-cpp/libggml-cpu-alderlake.so
| model                          |       size |     params | backend    | ngl | n_batch |            test |                  t/s |
| ------------------------------ | ---------: | ---------: | ---------- | --: | ------: | --------------: | -------------------: |
| gemma3 4B Q4_K - Medium        |   2.31 GiB |     3.88 B | RPC        |  99 |     512 |           pp512 |         24.61 ± 0.49 |
| gemma3 4B Q4_K - Medium        |   2.31 GiB |     3.88 B | RPC        |  99 |     512 |           tg128 |          9.09 ± 0.05 |

build: e8215dbb (5760)
```

## Ringkasan Hasilnya

| Mode CPU | Batch | Prefill (pp512) | Decode (tg128) |
| --- | --- | --- | --- |
| **powersave** | 64  | 24.84 t/s | 9.70 t/s |
| **powersave** | 512 | 25.25 t/s | 9.72 t/s |
| **performance** | 64  | 26.07 t/s | 9.06 t/s |
| **performance** | 512 | 24.61 t/s | 9.09 t/s |

Keterangan:

-   t/s maksudnya tokens per second
-   Prefill artinya seberapa cepat model bisa memproses prompt tokens dalam sekali masuk.
-   Decode artinya seberapa cepat model bisa menghasilkan new tokens setelah prompt selesai. 
-   Batch Size: jumlah token yang diproses sekaligus dalam satu langkah komputasi.