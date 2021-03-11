//
//  Store.swift
//  healthysleep
//
//  Created by Mac on 27/06/2021.
//

import Foundation

enum CacheType {
    case string
    case object
    case array
    case bool
}

final class Store {
    static let shared = Store()
    
    func setItem(value: Any?, key: String) {
        UserDefaults.standard.setValue(value, forKey: key)
    }
    
    func getItem<T>(as: T.Type, type: CacheType, key: String, completion: @escaping (T?) -> Void){
        var data: T?
        switch type {
        case .object:
            data = UserDefaults.standard.object(forKey: key) as? T
        case .string:
            data =  UserDefaults.standard.object(forKey: key) as? T
        case .array:
            data = UserDefaults.standard.object(forKey: key) as? T
        case .bool:
            data = UserDefaults.standard.bool(forKey:key) as? T
        }
        completion(data)
    }
    
    func deleteItem() {
       
    }
}
