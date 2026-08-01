console.log("Hello World");

import { invoke } from "@tauri-apps/api/tauri";

const cityInput = document.getElementById("city-input");
const btn = document.getElementById("btn");


btn.addEventListener("click", async () => {
    const city = cityInput.value;
    const weather = await invoke("get_weather", { city });
    console.log(weather);

});