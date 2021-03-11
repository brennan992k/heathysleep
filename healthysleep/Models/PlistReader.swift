//
//  PlistReader.swift
//  healthysleep
//
//  Created by Mac on 27/06/2021.
//

import Foundation

final class PlistReader {
    
    static let shared = PlistReader()
    
    enum PlistError: Error {
        case pathError
        case contentError
    }
    
    func readPlist(forResource: String, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        
        guard let path = Bundle.main.path(forResource: forResource, ofType: "plist")  else {
            completion(.failure(PlistError.pathError))
            return
        }
        
        guard let dict = NSDictionary(contentsOfFile: path) as? [String: Any] else {
            completion(.failure(PlistError.contentError))
            return
        }
        
        completion(.success(dict))
        return
    }
    
}
