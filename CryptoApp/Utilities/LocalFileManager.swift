//
//  LocalFileManager.swift
//  CryptoApp
//
//  Created by Andrei Isayenka on 08/03/2025.
//

import Foundation
import SwiftUI

final class LocalFileManager {
    
    static let instance = LocalFileManager()
    private init() {}
    
    
    public func save(image: UIImage, in folderName: String, as imageName: String) {
        
        // Create folder
        createFolderIfNeeded(name: folderName)
        
        // Get path for image
        guard
            let data = image.pngData(),
            let url = getURLForImage(name: imageName, folderName: folderName)
        else { return }
        
        // Save image to path
        do {
            try data.write(to: url)
        } catch let error {
            print("Error saving image \(imageName): \(error)")
        }
    }
    
    public func getImage(named: String, folderName: String) -> UIImage? {
        guard
            let url = getURLForImage(name: named, folderName: folderName),
            FileManager.default.fileExists(atPath: url.path())
        else { return nil }
        
        return UIImage(contentsOfFile: url.path())
    }
    
    private func createFolderIfNeeded(name: String) {
        guard let url = getURLForFolder(name: name) else { return }
        
        if !FileManager.default.fileExists(atPath: url.path()) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: false)
            } catch let error {
                print("Error creating directory \(name): \(error.localizedDescription)")
            }
        }
    }
    
    private func getURLForFolder(name: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
        return url.appendingPathComponent(name)
    }
    
    private func getURLForImage(name: String, folderName: String) -> URL? {
        guard let folderURL = getURLForFolder(name: folderName) else { return nil }
        return folderURL.appendingPathComponent(name + ".png")
    }
    
}
