//
//  FavoritesViewModel.swift
//  healthysleep
//
//  Created by Mac on 27/06/2021.
//

import Foundation

final class FavoritesViewModel {
    var sounds = [Sound]()
    
    init() {
        reloadData(completion: {_ in})
    }
    
    func reloadData (completion: @escaping (Bool) -> Void ) {
        FavoriteSounds.shared.reload()
        let favoriteSounds = FavoriteSounds.shared.favoriteSounds
        self.sounds = HeathySleepData.shared.soundsBy(nameKeys: favoriteSounds) ?? []
        completion(true)
    }
    
}
