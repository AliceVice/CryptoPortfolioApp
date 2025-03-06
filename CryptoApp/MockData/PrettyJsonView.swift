//
//  PrettyJsonView.swift
//  CryptoApp
//
//  Created by Andrei Isayenka on 06/03/2025.
//

import SwiftUI

struct PrettyJsonView: View {
    var body: some View {
        Button("Pretty Print JSON") {
            prettyPrintJSONFromBundle(fileName: "Coins")
            // assuming your file is named "Coins.json"
        }
        .foregroundStyle(.blue)
    }
    
}

#Preview {
    PrettyJsonView()
}


extension PrettyJsonView {
    private func prettyPrintJSONFromBundle(fileName: String, fileExtension: String = "json") {
        // 1. Locate the file in your app bundle
        guard let url = Bundle.main.url(forResource: fileName, withExtension: fileExtension) else {
            print("Could not find \(fileName).\(fileExtension) in bundle.")
            return
        }
        
        // 2. Load the data
        guard let data = try? Data(contentsOf: url) else {
            print("Could not load data from \(url.path).")
            return
        }
        
        // 3. Convert it to a JSON object, then re-encode with .prettyPrinted
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            let prettyData = try JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted])
            
            // 4. Convert prettyData back to String
            if let prettyString = String(data: prettyData, encoding: .utf8) {
                print("PRETTY PRINTED JSON:\n\(prettyString)")
                
                // OPTIONAL: Write it back to disk, e.g., in your Documents directory
                let documentsDir = try FileManager.default.url(for: .documentDirectory,
                                                               in: .userDomainMask,
                                                               appropriateFor: nil,
                                                               create: true)
                let outputURL = documentsDir.appendingPathComponent("pretty_\(fileName).\(fileExtension)")
                try prettyData.write(to: outputURL, options: .atomic)
                
                print("Pretty JSON saved at: \(outputURL.path)")
            }
        } catch {
            print("Error pretty printing JSON: \(error)")
        }
    }
}
