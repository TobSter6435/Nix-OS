const { invoke } = window.__TAURI__.core;


const cityInput = document.getElementById("city-input");
const btn = document.getElementById("btn");

const cityNameEl = document.getElementById("city-name");
const tempEl = document.getElementById("temp");
const feelsLikeEl = document.getElementById("feels-like");
const humidityEl = document.getElementById("humidity");
const windEl = document.getElementById("wind");
const visibilityEl = document.getElementById("visibility");
const descEl = document.getElementById("desc");

btn.addEventListener("click", async () => {

    const city = cityInput.value.trim();
    

    if (!city) return;

    try {
      
        const weather = await invoke("get_weather", { city });
        console.log("Wetterdaten empfangen:", weather);

        cityNameEl.innerText = city.toUpperCase();
        
  
        tempEl.innerText = `${Math.round(weather.temp)}°C`;
        feelsLikeEl.innerText = `${Math.round(weather.feels_like)}°C`;
        
        humidityEl.innerText = `${weather.humidity}%`;
        windEl.innerText = `${weather.wind} km/h`;
        

        visibilityEl.innerText = `${(weather.visibility / 1000).toFixed(1)} km`; 

        descEl.innerText = "Daten erfolgreich geladen!";

    } catch (error) {

        console.error("Fehler vom Backend:", error);
        

        alert(error); 
    }
});