//
//  HeathySleepData.swift
//  healthysleep
//
//  Created by Mac on 27/06/2021.
//

import Foundation

final class HeathySleepData {
    
    static let shared = HeathySleepData()
    private var plist = "heathysleep-data"
    private(set) var categories: [Category] = []
    private(set) var sounds: [Sound] = []
    
    init() {
        readData()
    }
    
    private func readData() {
        PlistReader.shared.readPlist(forResource: plist) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let dict):
                if let categories = dict["categories"] as? [[String: Any]] {
                    categories.forEach({
                        if let name_key = $0["name_key"] as? String, let image = $0["image"] as? String, let name = $0["name"] as? String, let sounds = $0["sounds"] as? [String] {
                            self.categories.append(Category(name_key: name_key , sounds: sounds, image: image , name: name))
                        }
                    })
                }
                if let sounds = dict["sounds"] as? [String: [String: Any]] {
                    sounds.forEach({
                        self.sounds.append(Sound(dict: $1))
                    })
                }
                
            }
        }
    }
    
    func soundsBy(nameKeys: [String]) -> [Sound]? {
        return sounds.filter { nameKeys.contains($0.name_key) }
    }
    
    func soundBy(nameKey: String) -> Sound? {
        return sounds.first(where: { $0.name_key == nameKey })
    }
    
    func reload () {
        readData()
    }
    
    func reload(plist: String) {
        self.plist = plist
        readData()
    }
    
}
