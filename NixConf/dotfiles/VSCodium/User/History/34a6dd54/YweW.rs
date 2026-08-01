#![cfg_attr(not(debug_assertions), windows_subsystem = "windows")]


use reqwest::blocking::Client;
use serde_json::{json, Value};
use dotenvy::dotenv;


const API_KEY = std::env::var("API_KEY").map_err(|_| "API-KEY-ERROR(are you sure about your API-KEY)? _" );

#[tauri::command]
fn get_weather(city: String) -> Result<Value, String> {
    let client = Client::new();
    let response = client.get(format!("https://api.openweathermap.org/data/2.5/weather?q={}&appid=b6907d289e10d714a6e88b30761fae22", city, api_key)).send().unwrap();
    let body = response.text().unwrap();


    let json: Value = serde_json::from_str(&body).map_err(|_|"JSON-ERROR(are you sure about your city)? _" )? ;

  
    let temp = json["main"]["temp"].as_f64().unwrap();
    let feels_like = json["main"]["feels_like"].as_f64().unwrap();
    let humidity = json["main"]["humidity"].as_f64().unwrap();
    let wind = json["wind"]["speed"].as_f64().unwrap();
    let visibility = json["visibility"].as_f64().unwrap();

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