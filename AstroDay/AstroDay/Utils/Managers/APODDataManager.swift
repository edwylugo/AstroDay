//
//  APODDataManager.swift
//  AstroDay
//
//  Created by Edwy Lugo on 02/02/25.
//

import Foundation

class APODDataManager {
    
    private let fileName = "apod.json"
    
    private func getURLFile() -> URL {
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        if !fileManager.fileExists(atPath: fileURL.path) {
            let emptyData = try? JSONEncoder().encode([APODModel]())
            try? emptyData?.write(to: fileURL)
        }
        
        return fileURL
    }
    
    func readAPODs() -> [APODModel] {
        let fileURL = getURLFile()
        do {
            let data = try Data(contentsOf: fileURL)
            return try JSONDecoder().decode([APODModel].self, from: data)
        } catch {
            debugPrint("Error reading file: \(error)")
            return []
        }
    }
    
    private func saveAPODs(_ apods: [APODModel]) {
        let fileURL = getURLFile()
        do {
            let data = try JSONEncoder().encode(apods)
            try data.write(to: fileURL)
        } catch {
            debugPrint("Error saving file: \(error)")
        }
    }
    
    func insertAPOD(_ novoAPOD: APODModel) -> String {
        var apods = readAPODs()
        if apods.contains(where: { $0.title == novoAPOD.title }) {
            return Strings.text_toast_already_added
        }
        apods.append(novoAPOD)
        saveAPODs(apods)
        return Strings.text_toast_successfully_added
    }
    
    func updateAPOD(_ novoAPOD: APODModel) {
        var apods = readAPODs()
        if let index = apods.firstIndex(where: { $0.title == novoAPOD.title }) {
            apods[index] = novoAPOD
            saveAPODs(apods)
            debugPrint("APOD updated successfully.")
        } else {
            debugPrint("Error: APOD with title \(novoAPOD.title) not found.")
        }
    }
    
    func deleteAPOD(title: String) -> String {
        var apods = readAPODs()
        if let index = apods.firstIndex(where: { $0.title == title }) {
            apods.remove(at: index)
            saveAPODs(apods)
            return Strings.text_toast_removed
        } else {
            return Strings.text_toast_not_found(text: title)
        }
    }
    
    func searchAPOD(title: String) -> APODModel? {
        let apods = readAPODs()
        return apods.first(where: { $0.title == title })
    }
}
