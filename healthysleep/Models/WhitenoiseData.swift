//
//  WhitenoiseData.swift
//  healthysleep
//
//  Created by Mac on 27/06/2021.
//

import Foundation


final class WhitenoiseData {
    
    static let shared = WhitenoiseData()
    private var plist = "whitenoise-data"
    
    private(set) var fadeValues =  [FadeValue]()
    private(set) var durationValues = [DurationValue]()
    
    init() {
        readData()
    }
    
    private func readData() {
        PlistReader.shared.readPlist(forResource: plist) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let dict):
                
                if let rawDuraionValues = dict["duration_values"] as? [[String: Any]] {
                    rawDuraionValues.forEach({
                        guard let display = $0["display"] as? String, let seconds = $0["seconds"] as? NSString else {
                            return
                        }
                        let durationValue = DurationValue(display: display, seconds: seconds.floatValue)
                        self.durationValues.append(durationValue)
                    })
                }
                
                if let rawFadeValues = dict["fade_values"] as? [[String: Any]] {
                    rawFadeValues.forEach({
                        guard let display = $0["display"] as? String, let seconds = $0["seconds"] as? NSString else {
                            return
                        }
                        let fadeValue = FadeValue(display: display, seconds: seconds.floatValue)
                        self.fadeValues.append(fadeValue)
                    })
                }
                
            }
        }
    }
    
    func reload () {
        readData()
    }
    
    func reload(plist: String) {
        self.plist = plist
        readData()
    }
    
}
