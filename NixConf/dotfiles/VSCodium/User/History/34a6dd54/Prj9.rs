#![cfg_attr(not(debug_assertions), windows_subsystem = "windows")]


use tauri::{Manager, State};
use reqwest::blocking::Client;
use tokio::runtime::Runtime;
use serde_json::Value;


#[tauri::command]
fn get_weather(city: String) -> Result<Value, ()> {
    let client = Client::new();
    let response = client.get(format!("https://api.openweathermap.org/data/2.5/weather?q={}&appid=b6907d289e10d714a6e88b30761fae22", city)).send().unwrap();
    let body = response.text().unwrap();


    let json: Value = serde_json::from_str(&body).map_err(|_|"JSON-ERROR(are you sure about your city)? _" )? ;

  
    let temp = json["main"]["temp"].as_f64().unwrap();
    let feels_like = json["main"]["feels_like"].as_f64().unwrap();
    let humidity = json["main"]["humidity"].as_f64().unwrap();
    let wind = json["wind"]["speed"].as_f64().unwrap();
    let visibility = json["visibility"].as_f64().unwrap();

    


    Ok((temp, feels_like, humidity, wind, visibility))
    
}


#[tokio::main]
async fn main() {
    tauri::Builder::default()
        .invoke_handler(tauri::generate_handler![])
        .run(tauri::generate_context!())
        .expect("Fehler beim Starten der Tauri-Anwendung");
}