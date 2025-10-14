# Membuat Bahasa Pemrograman Web yang Menggunakan Bahasa Manusia dengan LLM gemma3:1b

Karena saya mulai suka dengan Ollama dan LLM-nya, seperti gemma3:1b, maka malam tadi saya sengaja meluangkan waktu untuk mengerjakan sebuah bahasa pemrograman yang menggunakan bahasa manusia.

Untuk setup awal, Anda bisa baca [postingan ini](https://rakifsul.github.io/menginstall-ollama-dan-open-webui-di-ubuntu-2404-tanpa-docker.html).

Pada prinsipnya, bahasa pemrograman tadi sebenarnya adalah prompt, namun dengan system prompt yang setengah gagal (karena gagal menghapus markdown snippet), saya berhasil menampilkan button berwarna salmon di outputnya. 

Dan untuk solusi kegagalan tadi, system prompt yang gagal tadi saya akali dengan menggunakan kode javascript. Saya juga tidak tahu kenapa LLM tersebut tidak mematuhi system prompt yang menginstruksikan untuk me-remove karakter backtick (untuk snippet).

Jadi, kira-kira begini kode JavaScript-nya (index.js):

```javascript
// ollama endpoint
const ollamaAPIEndpoint = "http://localhost:11434/api/generate";

// ollama model
const ollamaModel = "gemma3:1b";

// system prompt ini gagal menghilangkan backtick untuk snippet. 
// barangkali Anda tahu solusinya selain dengan algoritma biasa?
const systemPrompt = `
jawab dengan kode html, css, dan javascript.
jawaban tadi harus tanpa format markdown sama sekali
dan tanpa format markdown snippet
dan tanpa karakter backtick snippet
harus seperti itu.
`;

// on load
window.addEventListener("load", async function () {
    // dapatkan elemen button
    const btnExec = document.getElementById("btn-exec")

    // saat elemen button diklik
    btnExec.addEventListener("click", async function (evt) {
        const prompt = document.getElementById("txa-prompt").value;
        console.log(prompt)
        await llmEval(prompt)
    })
})

// melakukan reply
async function llmEval(prompt) {
    // request ke ollama API
    const rawResponse = await fetch(ollamaAPIEndpoint, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            model: ollamaModel,
            prompt: prompt,
            system: systemPrompt,
            stream: false
        })
    });

    // cleanup response
    const jsonResponse = await rawResponse.json();
    let response = jsonResponse.response;
    response = removeMarkdownSnippet(response)
    console.log(response);

    // replace main window
    let mainWindow = document.getElementsByTagName('html')[0];
    mainWindow.innerHTML = response;

    // reload dan restore setelah 3 seconds
    setTimeout(function () {
        location.reload();
    }, 3000)
}

// solusi kegagalan system prompt
function removeMarkdownSnippet(text) {
    // RegEx untuk menangkap dan menghapus kode dalam tiga backtick + jenis bahasa
    return text.replace(/```[a-zA-Z0-9]*\s*(.*?)```/gs, '$1');
}
```

Dan ini kode HTML-nya (index.html):

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LLMEval.js v1.0.0</title>
    <link rel="stylesheet" href="index.css">
</head>

<body>
    <div>
        <h1>LLMEval.js - Human Coding Language</h1>
        <textarea id="txa-prompt"
            placeholder="tulis prompt anda di sini... (write a html of salmon colored button)"></textarea>
        <button id="btn-exec">Execute selama 3 Detik</button>
    </div>
    <script src="index.js"></script>
</body>

</html>
```

Copy

Dan ini kode CSS-nya (index.css):

```css
body {
    background-color: cornflowerblue;
    position: absolute;
    left: 20px;
    right: 20px;
    top: 20px;
    bottom: 20px;
}

h1 {
    color: salmon;
    background-color: gray;
    text-align: center;
    font-family: 'Courier New', Courier, monospace;
    padding-top: 1%;
}

textarea {
    position: relative;
    width: 100%;
    height: 70vh;
    box-sizing: border-box;
    font-family: 'Courier New', Courier, monospace;
}

button {
    position: relative;
    width: 100%;
    height: 5vh;
    font-family: 'Courier New', Courier, monospace;
    background-color: salmon;
}
```

Saya kira komentar pada kode tadi cukup jelas dan mudah dipahami.

Untuk menjalankannya, gunakan HTTP server. Jika langsung dari file, pasti tidak akan bekerja dengan benar.

Sekarang, setelah saya jalankan, maka outputnya seperti ini:

<p align="center">
    <img src="../media/Screenshot-from-2025-07-27-11-43-05.png?raw=true" alt="tampilan"/>
</p>

<p align="center">
    <img src="../media/Screenshot-from-2025-07-27-11-43-40.png?raw=true" alt="tampilan"/>
</p>

Dari tadi saya coba prompt yang sama seperti di contoh (write a html of salmon colored button) dan berhasil. Jadi, sebaiknya Anda coba yang lain.