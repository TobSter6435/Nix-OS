
#![cfg_attr(not(debug_assertions), windows_subsystem = "windows")]

use tauri::{Manager, State};


fn main() {
    tauri::Builder::default()
        .invoke_handler(tauri::generate_handler![])
        
}