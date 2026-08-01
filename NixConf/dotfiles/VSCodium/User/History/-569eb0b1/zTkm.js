// Tauri v2 Import
import { invoke } from "@tauri-apps/api/core";

// Eingabe und Button
const cityInput = document.getElementById("city-input");
const btn = document.getElementById("btn");

// Die HTML-Elemente, in die wir die Daten schreiben wollen
const cityNameEl = document.getElementById("city-name");
const tempEl = document.getElementById("temp");
const feelsLikeEl = document.getElementById("feels-like");
const humidityEl = document.getElementById("humidity");
const windEl = document.getElementById("wind");
const visibilityEl = document.getElementById("visibility");
const descEl = document.getElementById("desc");

btn.addEventListener("click", async () => {
    // 1. Stadt auslesen und Leerzeichen am Rand entfernen
    const city = cityInput.value.trim();
    
    // Wenn das Feld leer ist, mach gar nichts
    if (!city) return;

    try {
        // 2. Rust Backend aufrufen
        const weather = await invoke("get_weather", { city });
        console.log("Wetterdaten empfangen:", weather);

        // 3. HTML-Elemente mit den echten Daten füllen
        cityNameEl.innerText = city.toUpperCase();
        
        // Math.round rundet die Temperatur auf ganze Zahlen (z.B. 18°C statt 18.45°C)
        tempEl.innerText = `${Math.round(weather.temp)}°C`;
        feelsLikeEl.innerText = `${Math.round(weather.feels_like)}°C`;
        
        humidityEl.innerText = `${weather.humidity}%`;
        windEl.innerText = `${weather.wind} km/h`;
        
        // Sichtweite kommt von der API in Metern, wir rechnen es in Kilometer um
        visibilityEl.innerText = `${(weather.visibility / 1000).toFixed(1)} km`; 
        
        // Platzhalter für die Beschreibung, da diese noch nicht im Rust-Code ist
        descEl.innerText = "Daten erfolgreich geladen!";

    } catch (error) {
        // 4. Fehler abfangen (z.B. wenn die Stadt nicht gefunden wurde)
        console.error("Fehler vom Backend:", error);
        
        // Zeigt die Fehlermeldung aus dem Rust-Code als Popup an
        alert(error); 
    }
});