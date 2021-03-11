//
//  Sound.swift
//  heathysleep
//
//  Created by Mac on 24/06/2021.
//

import Foundation

struct Sound: Equatable {
    
    var audio_loop = ""
    var name_key = ""
    var image = ""
    var audio_start = ""
    var name = ""
    
    init(dict: [String: Any]) {
        if let image = dict["image"] as? String {
            self.image = image
        }
        if let name_key = dict["name_key"] as? String {
            var arr = name_key.split(separator: "_")
            arr.removeFirst()
            self.name = arr.joined(separator: " ")
            self.name_key = arr.joined(separator: "_")
        }
        if let audio_start = dict["audio_start"] as? String {
            let arr = audio_start.split(separator: ".")
            self.audio_start = String(arr[0])
        }
        if let audio_loop = dict["audio_loop"] as? String {
            let arr = audio_loop.split(separator: ".")
            self.audio_loop = String(arr[0])
        }
    }
}
