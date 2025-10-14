# Tutorial llama.cpp Seri 6 - Kenapa Bash Begitu Menarik

Sebelum saya menggunakan llama.cpp, saya menggunakan Ollama dengan Open WebUI.

Dulu saya lebih tertarik menggunakan web ui karena saya belum paham betul soal LLM.

Konsep tersebut masih abstrak.

Setelah saya beberapa kali menggunakannya, saya mulai bisa membedakan mana yang disebut model, dan apa yang menjalankan model tersebut.

Jadi, menggunakan user interface grafis di awal sebenarnya ada manfaatnya, yakni untuk memahami sesuatu yang lebih abstrak jika dilakukan dengan scripting seperti dengan bash.

Walaupun begitu, keleluasaan penggunaan bash belum bisa dikalahkan oleh user interface berbasis grafis.

Itu karena bash mampu mewujudkan apa yang kita planning dalam otak kita asalkan kita mampu mengutarakannya dalam script dan masih dalam scope kemampuan script tersebut.

## Menjalankan llama-cli Sekali, kemudian Langsung Exit

Sebagai contoh, dengan bash, saya bisa melakukan ini:

```bash
# $models adalah variabel berisi path folder di mana model-model saya berada.
# argument -st digunakan agar hanya sekali jalan, kemudian langsung exit.
llama-cli -m $models/ggml-org_gemma-3-1b-it-GGUF_gemma-3-1b-it-Q4_K_M.gguf -p "hai. balas dengan 1 kalimat saja" -st > gak-penting.txt
```

Di situ, saya bisa memasukkan respon dari prompt yang ada di argument -p ke dalam file bernama "gak-penting.txt".

## Bertanya Beberapa Kali dengan Satu Script

Jika Anda kurang puas dengan prompt sebelumnya, Anda bisa mengulanginya 3 kali dengan kalimat yang berbeda:

```bash
for prompt in "Halo" "Apa kabar" "hai"; do
    llama-cli -m $models/ggml-org_gemma-3-1b-it-GGUF_gemma-3-1b-it-Q4_K_M.gguf -p "$prompt" -st > "$prompt.txt"
done
```

Masih belum puas juga? Coba buat yang 100 kali.

## Manajemen Resource

htop, nvidia-smi, dan free -h bisa berguna untuk mengawasi resource Anda saat menjalankan llama.cpp. Cukup masukkan perintah tadi di tab baru terminal Anda.

Ini cocok untuk saya karena biasanya resource usage yang semakin dekat dengan 0% sangat memberi kepuasan bagi saya jika saya sedang menjalankan program yang berat.

## Konversi .safetensors ke .gguf

Beberapa model dipublikasi tanpa format .gguf.

Jika model tersebut Anda butuhkan, maka Anda bisa menggunakan tool dari llama.cpp yang berbentuk script python.

Untuk menjalankannya? Dengan bash. Contohnya [ada di artikel ini](https://rakifsul.github.io/tutorial-llamacpp-seri-5-konversi-model-ke-gguf-dan-kuantisasinya.html).

## Menjalankan llama-server saat Komputer Booting

llama-server bisa menyediakan web interface bawaan llama.cpp. Lengkap dengan konfigurasinya.

Jika untuk menjalankannya secara sadar caranya seperti ini:

```bash
llama-server -m /path/to/model.gguf --host 127.0.0.1 --port 8081
```

Maka cara menjalankannya secara tidak sadar saat reboot seperti ini:

```apacheconf
crontab -e

# masuk text editor, lalu isi di paling bawah:
@reboot /path/absolut/dari/llama-server -m /path/absolut/dari/model.gguf --host 127.0.0.1 --port 8081 &

# jangan lupa pakai & di akhir command.
```

## Membuat CLI Cerdas yang bisa Memahami Command dalam Bahasa Manusia

Error: jatah tokennya sudah habis. [Kunjungi tutorialnya di sini](https://karyakarsa.com/rakifsul/ngoding-aplikasi-cli-cerdas-tanpa-ribet-biarkan-llm-menulis-kode-aplikasi-llm).

## Mengetahui Command Arguments yang Paling Optimal pada perintah yang ada pada llama.cpp

Error: jatah tokennya sudah habis. [Kunjungi script-nya di sini](https://karyakarsa.com/rakifsul/rf-llm-optimum-finder).

## Akhir Kata

Jadi itulah kenapa belajar bash itu menarik.