//
//  HomeViewModel.swift
//  healthysleep
//
//  Created by Mac on 27/06/2021.
//

import Foundation

final class HomeViewModel {
    var categories = [Category]()
    
    init() {
        categories =  HeathySleepData.shared.categories 
    }
    
}
