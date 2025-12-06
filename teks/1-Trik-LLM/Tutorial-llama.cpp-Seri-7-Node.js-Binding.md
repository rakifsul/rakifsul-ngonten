# Tutorial llama.cpp Seri 7 Node.js Binding

Di tutorial llama.cpp sebelumnya (Seri 6), kita membahas sebagian kecil tentang bagaimana prompt diproses secara terprogram dengan Bash.

Namun, saya rasa penting untuk membahas hal tersebut sekali lagi, namun dengan menggunakan Node.js binding.

Itu karena akses yang bisa didapatkan untuk memprogram llama.cpp bisa lebih banyak.

Jika di bash kita telah menyaksikan bagaimana llama-cli dijalankan secara terprogram di level yang lebih tinggi, maka dengan Node.js binding, kita bisa mengakses fungsi llama.cpp di level yang lebih rendah.

Sebagai contoh, mungkin, di bash kita bisa melakukan loop berisi berbagai prompt dan menjalankannya satu per satu secara terprogram dengan bash.

Di Node.js binding, kita bahkan bisa menggunakan fitur chat, completion, embeddings, dan grammar.

Namun, secara default, program yang menggunakan Node.js binding terhadap llama.cpp harus berjalan di komputer di mana llama.cpp prompt diproses.

Jadi, jika Anda ingin menggunakan pc spek tinggi untuk Node.js binding terhadap llama.cpp, maka program yang menjalankan aplikasi dengan Node.js binding tadi harus dijalankan di komputer tersebut.

Lalu bagaimana cara menggunakan Node.js binding?

Pertama, Anda membutuhkan Node.js yang bisa diinstall dengan [nvm](https://github.com/nvm-sh/nvm) atau dari [situs resminya](https://nodejs.org/en).

Setelah terinstall, buatlah sebuah folder dan sebuah file bernama index.js di dalamnya.

Selain itu buat juga folder models di dalam folder project.

```
mkdir ./project
cd ./project
touch index.js
mdkdir ./models
```

Kemudian dari dalam folder project, jalankan:

```
npm init -y
```

Lalu, install package bernama:

```
npm install node-llama-cpp
```

Langkah selanjutnya adalah menyiapkan model LLM yang bisa Anda dapatkan di [Hugging Face](https://huggingface.co).

Setelah di-download, masukkan ke dalam folder project/models.

Sebagai contoh, saya menggunakan model bernama "gemma-3-1b-it-q4_k_m.gguf".

```
cp /path/sumber/model/gemma-3-1b-it-q4_k_m.gguf /path/project/nodejs/barusan/models
```

Selanjutnya, buka file index.js yang telah kita buat tadi:

```
nano ./index.js
```

Kemudian isi dengan script Node.js ini:

```
import {fileURLToPath} from "url";
import path from "path";
import {getLlama, LlamaChatSession} from "node-llama-cpp";

const llama = await getLlama();
const model = await llama.loadModel({
    modelPath: path.join("./", "models", "gemma-3-1b-it-q4_k_m.gguf")
});
const context = await model.createContext();
const session = new LlamaChatSession({
    contextSequence: context.getSequence()
});


const prompt1 = "apa kabar?";
console.log(`user => ${prompt1}`);

const jawaban1 = await session.prompt(prompt1);
console.log(`ai => ${jawaban1}`);


const prompt2 = "simpulkan jawaban anda tadi";
console.log("user: " + prompt2);

const jawaban2 = await session.prompt(prompt2);
console.log("ai: " + jawaban2);
```

Selanjutnya, jalankan dengan perintah ini:

```
node index.js
```

Hasilnya seperti ini:

```
[node-llama-cpp] load: special_eos_id is not in special_eog_ids - the tokenizer config may be incorrect
user => apa kabar?
ai => Baik, terima kasih! Bagaimana denganmu?

(I'm good, thanks! How about you?)

Saya berfungsi dengan baik dan siap membantu. Ada yang bisa saya bantu?
user: simpulkan jawaban anda tadi
ai: Jawaban saya sebelumnya adalah: "Baik, terima kasih! Bagaimana denganmu?" yang berarti "I'm good, thanks! How about you?"

Jadi, jawaban singkatnya adalah: **Saya baik, bagaimana denganmu?** (I'm good, how about you?)
```

Itu adalah sebagian kecil dari contoh penggunaan llama.cpp binding dengan menggunakan Node.js.

Jika Anda tertarik mempelajarinya lebih lanjut, silakan kunjungi [repository-nya](https://github.com/withcatai/node-llama-cpp) atau [dokumentasinya](https://node-llama-cpp.withcat.ai/guide/).