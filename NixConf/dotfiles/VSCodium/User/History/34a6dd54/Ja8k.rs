#![cfg_attr(not(debug_assertions), windows_subsystem = "windows")]


use tauri::{Manager, State};
use reqwest::blocking::Client;
use tokio::runtime::Runtime;

fn main() {
    tauri::Builder::default()
        .invoke_handler(tauri::generate_handler![])
        .run(tauri::generate_context!())
        .expect("Fehler beim Starten der Tauri-Anwendung");
}