//
//  TimeInterval.swift
//  healthysleep
//
//  Created by Mac on 29/06/2021.
//

import Foundation

extension TimeInterval{
    func toSeconds() -> Float {
        let ti = NSInteger(self)
        let seconds = ti % 60
        let minutes = (ti / 60) % 60
        let hours = (ti / 3600)
        return Float(seconds + hours * 60 * 60 + minutes * 60)
        
    }
    
}
