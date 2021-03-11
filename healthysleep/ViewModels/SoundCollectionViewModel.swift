//
//  SoundCollectionViewModel.swift
//  healthysleep
//
//  Created by Mac on 27/06/2021.
//

import Foundation

final class SoundCollectionViewModel {
    var category: Category?
    var sounds = [Sound]()
    
    init(category: Category) {
        self.category = category
        self.sounds = HeathySleepData.shared.soundsBy(nameKeys: category.sounds) ?? []
    }
    
}
