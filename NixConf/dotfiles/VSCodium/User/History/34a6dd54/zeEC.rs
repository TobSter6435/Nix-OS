#![cfg_attr(not(debug_assertions), windows_subsystem = "windows")]

use reqwest::blocking::Client;
use serde_json::{json, Value};
use dotenvy::dotenv;

#[tauri::command]
fn get_weather(city: String) -> Result<Value, String> {

    dotenv().ok();


    let api_key = std::env::var("API_KEY")
        .map_err(|_| "API_KEY fehlt in der .env Datei!")?;

    let client = Client::new();
    let url = format!(
        "https://api.openweathermap.org/data/2.5/weather?q={}&appid={}&units=metric", 
        city, api_key
    );

    let response = client.get(&url).send()
        .map_err(|_| "Netzwerkfehler: OpenWeather nicht erreichbar.")?;
        
    let body = response.text()
        .map_err(|_| "Fehler beim Lesen der Antwort.")?;

    let json: Value = serde_json::from_str(&body)
        .map_err(|_| "JSON-ERROR (are you sure about your city)?")?;


    if json["cod"] != 200 {
        return Err("Stadt nicht gefunden oder API-Fehler!".to_string());
    }
  
    let temp = json["main"]["temp"].as_f64().ok_or("Temperatur fehlt")?;
    let feels_like = json["main"]["feels_like"].as_f64().ok_or("Gefühlte Temperatur fehlt")?;
    let humidity = json["main"]["humidity"].as_f64().ok_or("Luftfeuchtigkeit fehlt")?;
    let wind = json["wind"]["speed"].as_f64().ok_or("Windgeschwindigkeit fehlt")?;
    let visibility = json["visibility"].as_f64().ok_or("Sichtweite fehlt")?;

    println!("Temperatur: {}", temp);
    println!("Gefühltes Temperatur: {}", feels_like);
    println!("Luftfeuchtigkeit: {}", humidity);
    println!("Windgeschwindigkeit: {}", wind);
    println!("Sichtbarkeit: {}", visibility);

    Ok(json!({
        "temp": temp,
        "feels_like": feels_like,
        "humidity": humidity,
        "wind": wind,
        "visibility": visibility
    }))
}

fn main() {
    tauri::Builder::default()
        .invoke_handler(tauri::generate_handler![get_weather])
        .run(tauri::generate_context!())
        .expect("Fehler beim Starten der Tauri-Anwendung");
}