# Tutorial Singkat Bot Mastodon dengan Local LLM gemma3:1b dan Ollama

Sudah sekitar beberapa hari sejak saya posting artikel [cara install Ollama](https://rakifsul.github.io/menginstall-ollama-dan-open-webui-di-ubuntu-2404-tanpa-docker.html) dan juga [cara install Mastodon](https://rakifsul.github.io/mencoba-kembali-untuk-install-mastodon-dengan-docker.html).

Saya harap durasi tersebut cukup lama untuk melakukan trial error dalam menginstall kedua aplikasi tadi.

Sekarang, saya asumsikan bahwa kita telah menjalankan kedua aplikasi tadi dan tentunya menggunakan sistem operasi Ubuntu.

Saatnya melakukan hal yang lebih menarik.

Saya akan membuat bot untuk Mastodon dengan menggunakan LLM untuk mengomentari status dan mem-favorite-kan status tadi jika menurut bot lucu.

Di sini, saya tidak akan banyak membahas kode yang saya tulis dengan JavaScript dan Node.js ini.

Itu karena saya telah memberi banyak komentar pada kode tersebut.

Jadi, jika Anda ingin paham apa yang dilakukan kode tadi, saya sarankan untuk membaca komentarnya dan juga dokumentasi serta sumber-sumber lainnya yang relevan.

Modul Node.js yang saya gunakan untuk aplikasi bot ini adalah [masto.js](https://github.com/neet/masto.js).

Waktu saya baca readme-nya, saya melihat ada sesuatu yang berbeda saat menginstall modul masto.js.

```bash
npm init --yes
npm pkg set type=module

npm install masto
```

Ada npm pkg set type=module.

Mungkin karena kita menggunakan ES6 import, bukan commonjs require.

Bisa dipastikan dari package.json hasilnya:

```json
"type": "module"
```

## Sekarang, bagaimana cara memulainya setelah itu?

Pertama, pastikan Ollama Anda telah mem-pull gemma3:1b:

```bash
ollama pull gemma3:1b
```

Jika Anda telah mengikuti [artikel ini](https://rakifsul.github.io/menginstall-ollama-dan-open-webui-di-ubuntu-2404-tanpa-docker.html), seharusnya sudah.

Kedua, pastikan Anda telah membuat aplikasi di Mastodon dan mendapatkan access token-nya.

Buka preferences > development > new application, lalu lihat gambar ini dan silakan tiru (pastikan centang read,profile,write,follow,push):

<p align="center">
    <img src="../media/Screenshot-from-2025-07-20-03-02-17-2.png?raw=true" alt="tampilan"/>
</p>

<p align="center">
    <img src="../media/Screenshot-from-2025-07-20-03-02-25-2.png?raw=true" alt="tampilan"/>
</p>

Nanti access token tersebut akan diinputkan ke fungsi untuk membuat rest api client dan streaming client.

Ketiga, buat file "index.js" dan install masto.js seperti cara di awal artikel ini.

```bash
npm init --yes
npm pkg set type=module

npm install masto
```

Kode ada di bagian selanjutnya.

## Bagaimana Source Code-nya?

Berikut ini adalah source code-nya dan bacalah komentarnya agar mengerti.

```javascript
process.env["NODE_TLS_REJECT_UNAUTHORIZED"] = 0

// createStreamingAPIClient untuk event seputar status, lihat dokumentasi.
// https://neet.github.io/masto.js/functions/createStreamingAPIClient.html

// createRestAPIClient untuk posting status, favorite, dan sebagainya, lihat dokumentasi.
// https://neet.github.io/masto.js/functions/createRestAPIClient.html
import { createStreamingAPIClient, createRestAPIClient } from "masto";

// domain mastodon di komputer lokal
const domainName = "mastodon.local";

// username dari @username
const targetUsername = "nama username anda";

// dari mastodon developer setting
const accessToken = "access token yang ada di mastodon anda";

// kali ini pilih yang /generate, karena bot yang kita buat adalah
// mengomentari status dan bukan untuk chat.
// jika ambil yang /chat, maka kita harus mengurus array dari history percakapan.
// di sini kita ambil yang /generate.
// http://localhost:11434/api/generate
// http://localhost:11434/api/chat
const ollamaAPIEndpoint = "http://localhost:11434/api/generate";

// model llm yang digunakan di ollama
// untuk menggunakan model, harus di-pull dulu
// dalam kasus ini:
// ollama pull gemma3:1b
// lakukan itu di terminal setelah menginstall ollama.
const ollamaModel = "gemma3:1b";

// core

// variabel untuk mereferensikan streaming API client
let streamingAPI;

// variabel untuk mereferensikan rest API client
let restAPI;

// array yang menampung daftar status id yang sudah difavorite/dibiarkan,
// supaya tidak terlalu banyak request ke ollama API.
let statusContainer = [];

// fungsi untuk inisialisasi
async function init() {
    streamingAPI = createStreamingAPIClient({
        streamingApiUrl: `wss://${domainName}`,
        accessToken: accessToken,
    });
    restAPI = createRestAPIClient({
        url: `https://${domainName}`,
        accessToken: accessToken,
    });
}

// subscribe streaming
async function subscribePublic() {
    for await (const event of streamingAPI.public.subscribe()) {
        switch (event.event) {
            // daftar event lihat: https://neet.github.io/masto.js/interfaces/mastodon.streaming.EventRegistry.html
            case "update": {
                // jika ada status baru
                console.log("post baru", event.payload.account.acct);
                // acct bagian dari Status. Lihat: https://neet.github.io/masto.js/interfaces/mastodon.v1.Status.html
                const username = event.payload.account.acct;

                if (username === targetUsername) {
                    await llmReply(restAPI, event.payload.content, event.payload.id);
                }
                break;
            }
            case "status.update": {
                // jika status diubah.
                console.log("post update", event.payload.account.acct);
                const username = event.payload.account.acct;
                if (username === targetUsername) {
                    const reply = await restAPI.v1.statuses.create({
                        status: "Eh? Kok diubah?",
                        inReplyToId: event.payload.id,
                        visibility: 'public', 
                    });
                }
                break;
            }
            case "delete": {
                // jika status dihapus
                console.log("post delete", event.payload);
                break;
            }
            default: {
                break;
            }
        }
    }
};

// poll status
async function makeFavorite() {
    let i = 0;
    // untuk setiap status-status dalam timeline public
    for await (const statuses of restAPI.v1.timelines.public.list()) {
        // untuk setiap status dalam status-status
        for (const status of statuses) {
            if (statusContainer.find(function (val) { return val === status.id })) {
                // jika status container sudah memiliki status id yang sudah dicek favorite/biarkan
                // jangan lakukan apa-apa.
            } else {
                // jika belum dicek favorite/biarkan
                console.log(status.account.acct + " - " + status.id)
                await llmNeedToFavorite(restAPI, status.content, status.id);
                statusContainer.push(status.id);
            }

            i += 1;
        }
        // batasi pengecekan status
        if (i >= 10) break;
    }
}

// memfavoritkan status lucu
async function llmNeedToFavorite(masto, prompt, statusId) {
    // request ke ollama API
    fetch(ollamaAPIEndpoint, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            model: ollamaModel,
            // untuk mendapatkan opini dari model tentang lucu/tidaknya status kita.
            prompt: `apakah prompt ini: "${prompt}" terdengar lucu? jawab dengan ya atau tidak saja.`,
            stream: false
        })
    })
        .then(response => response.json())
        .then(async data => {
            // pastikan tanpa formatting.
            const replyValue = data.response.toLowerCase().replace(/[^\w]/g, "");
            console.log('response plaintext: ', replyValue);

            if (replyValue === "ya") {
                console.log("status disukai...")
                await masto.v1.statuses.$select(statusId).favourite();
            } else {
                console.log("status tidak disukai/biarkan...")
                // await masto.v1.statuses.$select(statusId).unfavourite();
            }
        })
        .catch(error => {
            console.error('Error:', error);
        });
    //
}

// melakukan reply
async function llmReply(masto, prompt, statusId) {
    // request ke ollama API
    fetch(ollamaAPIEndpoint, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            model: ollamaModel,
            prompt: prompt,
            // system prompt digunakan untuk meyakinkan bahwa output dari model tidak berformat dan hanya terdiri dari 3 hingga 5 kalimat saja.
            system: `Jawab dengan teks biasa tanpa format markdown dan tanpa format apapun. Jawab hanya dalam 3 sampai 5 kalimat saja.`,
            stream: false
        })
    })
        .then(response => response.json())
        .then(async data => {
            console.log('response plaintext: ', data.response);
            const replyValue = data.response;

            // buat status
            const reply = await masto.v1.statuses.create({
                status: replyValue,
                inReplyToId: statusId,
                visibility: 'public',
            });
        })
        .catch(error => {
            console.error('Error:', error);
        });
    //
}

// init mastodon api
await init();
console.log("core: init...")

// poll for statuses tiap 5 detik
setInterval(async () => {
    try {
        await makeFavorite();
    } catch (error) {
        console.error(error);
    }
}, 5000);
console.log("core: poll for statuses...")

// subscribe streaming
try {
    console.log("core: subscribe streaming...")
    await subscribePublic();
} catch (error) {
    console.error(error);
}
```

Begitulah...

## Bagaimana cara menjalankannya?

Lakukan ini:

```bash
node index.js
```

Untuk menghentikannya, tekan CTRL+c pada terminal.

## Hasilnya

Beginilah hasilnya:

<p align="center">
    <img src="../media/Screenshot-from-2025-07-20-02-46-06.png?raw=true" alt="tampilan"/>
</p>

<p align="center">
    <img src="../media/Screenshot-from-2025-07-20-02-46-24.png?raw=true" alt="tampilan"/>
</p>

Lihat bahwa status saya yang "1+1 = dua-duanya buat gw" dianggap lucu oleh bot, sedangkan yang satu lagi tidak.

Gambar yang lain memperlihatkan teks dari jawaban bot terhadap status saya.