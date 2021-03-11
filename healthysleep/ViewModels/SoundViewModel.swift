//
//  File.swift
//  healthysleep
//
//  Created by Mac on 27/06/2021.
//

import Foundation

final class SoundViewModel {
    
    var state: PlaybackState {
        return PlaybackPresenter.shared.state
    }
    
    init(sound: Sound) {
        PlaybackPresenter.shared.confiure(sound: sound)
    }
    
    func play(completion : ((Bool) -> Void)?) {
        PlaybackPresenter.shared.play(completion: completion)
    }
    
    func pause(completion : ((Bool) -> Void)?) {
        PlaybackPresenter.shared.pause(completion: completion)
    }
    
    func stop(completion : ((Bool) -> Void)?) {
        PlaybackPresenter.shared.stop(completion: completion)
    }
    
    func changeVolume (value: Float, completion : ((Bool) -> Void)?) {
        PlaybackPresenter.shared.changeVolume(value: value, completion: completion)
    }
    
    func changeDuration (value: DurationValue, completion:((Bool) -> Void)?) {
        self.stop(completion: { _ in })
        PlaybackPresenter.shared.changeDuration(value: value, completion: completion)
    }
    
    func changeFadeOut(value: FadeValue, completion:((Bool) -> Void)?) {
        PlaybackPresenter.shared.changeFade(value: value, completion: completion)
    }
    
    func changeAlarm(value: Date, completion:((Bool) -> Void)?) {
        PlaybackPresenter.shared.changeAlarm(value: value, completion: completion)
    }
    
    func toggleFavorite (completion: ((Bool) -> Void)?) {
        PlaybackPresenter.shared.toggleFavorite(completion: completion)
    }
    
    func on(_ observer: Any, selector: Selector) {
        PlaybackPresenter.shared.on(observer, selector: selector, playbackNotfication: .All)
    }
}
