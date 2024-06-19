//
//  ViewController.swift
//  Align
//
//  Created by William Rule on 6/17/24.
//

import SwiftUI
import Supabase

class ViewController: UIViewController {
    var supabaseClient: SupabaseClient!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize Supabase client
        let supabaseUrl = URL(string: "https://efdkjonuigverdgalmhl.supabase.co")!
        let supabaseAnonKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVmZGtqb251aWd2ZXJkZ2FsbWhsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTg2ODIyMjAsImV4cCI6MjAzNDI1ODIyMH0.8jfhTehddnmyUHEkrXGsA4jny7nxPn-PVAAFC0cTKPQ"
        supabaseClient = SupabaseClient(supabaseURL: supabaseUrl, supabaseKey: supabaseAnonKey)
    }
}


