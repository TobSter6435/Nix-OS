#![cfg_attr(not(debug_assertions), windows_subsystem = "windows")]

// Deine Rust-Funktion für das Frontend
#[tauri::command]
fn my_custom_command() -> String {
    "Hallo aus Rust!".into()
}

fn main() {
    tauri::Builder::default()
        // Hier wird die Funktion registriert
        .invoke_handler(tauri::generate_handler![my_custom_command])
        // .run() startet die eigentliche Anwendung
        .run(tauri::generate_context!())
        .expect("Fehler beim Starten der Tauri-Anwendung");
}