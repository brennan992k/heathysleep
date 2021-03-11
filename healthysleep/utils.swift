//
//  utils.swift
//  healthysleep
//
//  Created by Mac on 28/06/2021.
//

import Foundation

func hmsFrom(seconds: Int, completion: @escaping (_ hours: Int, _ minutes: Int, _ seconds: Int)->()) {
    completion(seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
}

func getStringFrom(seconds: Int) -> String {
    return seconds < 10 ? "0\(seconds)" : "\(seconds)"
}
