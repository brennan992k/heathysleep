//
//  PlaybackPresenter.swift
//  healthysleep
//
//  Created by Mac on 27/06/2021.
//

import Foundation
import UIKit

enum PlaybackPresenterNotification {
    case All
    case State
    
    var name: Notification.Name {
        switch self {
        case .All: return Notification.Name("All")
        case .State: return Notification.Name("State")
        }
    }
}

enum PSField {
    case sound
    case fadeOut
    case duration
    case state
    case progressionTo
    case percentage
    case alarm
    case isFavorites
}

class PlaybackState {
    var sound: Sound?
    var fadeOut = FadeValue(display: " 0s", seconds: 0)
    var duration = DurationValue(display: "30s", seconds: 30)
    var state: AudioPlayerState = .buffering
    var progressionTo: Float = 0
    var percentage: Float = 0
    var alarm: Date?
    var isFavorites: Bool {
        guard let sound = self.sound else {
            return false
        }
        return FavoriteSounds.shared.has(with: sound)
    }
    var timeRemaining: Float {
        return duration.seconds - progressionTo
    }
    
    init() {
        
    }
    
    init(sound: Sound, fadeOut: FadeValue, duration: DurationValue, state: AudioPlayerState, progressionTo: Float, percentage: Float, alarm: Date) {
        self.sound = sound
        self.fadeOut = fadeOut
        self.duration = duration
        self.state = state
        self.progressionTo = progressionTo
        self.percentage = percentage
        self.alarm = alarm
    }
    
}

final class PlaybackPresenter {
    
    static let shared = PlaybackPresenter()
    private var player: AudioPlayer?
    private(set) var state = PlaybackState()
    
    func confiure(sound: Sound?) {
        /// create player
        createPlayer()
        /// config
        if state.sound?.name_key != sound?.name_key {
            state.sound = sound
            player?.stop()
            emit(playbackNotfication: .All, state: state, changed: [.sound, .fadeOut, .duration, .percentage, .progressionTo, .state, .isFavorites])
        }
        
    }
    
    private func createPlayer () {
        if player == nil {
            player = AudioPlayer()
            player?.delegate = self
        }
    }
    
    private func createPlayerItem () -> AudioItem? {
        guard let url = Bundle.main.url(forResource: state.sound?.audio_loop, withExtension: "m4a") else { return nil}
        guard let item = AudioItem(mediumQualitySoundURL: url) else { return nil}
        return item
    }
    
    public func play (completion: ((Bool) -> Void)?) {
        
        /// create player
        createPlayer()
        
        /// create audio item and start playing
        guard let item = createPlayerItem() else {
            return
        }
        player?.play(item: item)
    }
    
    public func resume(completion: ((Bool) -> Void)?) {
        guard let player = player else {
            completion?(false)
            return
        }
        player.resume()
        completion?(true)
    }
    
    public func pause(completion: ((Bool) -> Void)?) {
        guard let player = player else {
            completion?(false)
            return
        }
        player.pause()
        completion?(true)
    }
    
    public func stop(completion: ((Bool) -> Void)?) {
        guard let player = player else {
            completion?(false)
            return
        }
        player.stop()
        completion?(true)
    }
    
    public func changeVolume(value: Float, completion: ((Bool) -> Void)?) {
        player?.volume = value
        completion?(true)
    }
    
    public func changeDuration(value: DurationValue, completion: ((Bool) -> Void)?) {
        state.duration = value
        emit(playbackNotfication: .All, state: state, changed: [.duration])
        completion?(true)
    }
    
    public func changeFade(value: FadeValue, completion: ((Bool) -> Void)?) {
        state.fadeOut = value
        emit(playbackNotfication: .All, state: state, changed: [.fadeOut])
        completion?(true)
    }
    
    public func changeAlarm(value: Date, completion: ((Bool) -> Void)?) {
        self.state.alarm = value
        self.emit(playbackNotfication: .All, state: state, changed: [.alarm])
        completion?(true)
    }
    
    public func toggleFavorite (completion: ((Bool) -> Void)?) {
        guard let nameKey = state.sound?.name_key else {
            completion?(false)
            return
        }
        if state.isFavorites {
            FavoriteSounds.shared.delete(nameKey: nameKey, completion: completion)
        } else {
            FavoriteSounds.shared.add(nameKey: nameKey, completion: completion)
        }
        completion?(true)
        emit(playbackNotfication: .All, state: state, changed: [.isFavorites])
    }
    
    func on(_ observer: Any, selector: Selector) {
        PlaybackPresenter.shared.on(observer, selector: selector, playbackNotfication: .All)
    }
    
    private func emit(playbackNotfication: PlaybackPresenterNotification, state: PlaybackState, changed: [PSField]) {
        if changed.contains(.state) {
            NotificationCenter.default.post(name: PlaybackPresenterNotification.State.name, object: self, userInfo: ["state": state, "changed": changed])
        }
        NotificationCenter.default.post(name: playbackNotfication.name, object: self, userInfo: ["state": state, "changed": changed])
    }
    
    public func on(_ observer: Any, selector: Selector, playbackNotfication: PlaybackPresenterNotification) {
        NotificationCenter.default.addObserver(observer, selector: selector, name: playbackNotfication.name, object: nil)
    }
    
    public func remoteControlReceived(with event: UIEvent?) {
        if let event = event {
            if let player = player {
                player.remoteControlReceived(with: event)
            }
        }
    }
    
}

extension PlaybackPresenter: AudioPlayerDelegate {
    func audioPlayer(_ audioPlayer: AudioPlayer, didChangeStateFrom from: AudioPlayerState, to state: AudioPlayerState) {
        self.state.state = state
        emit(playbackNotfication: .All, state: self.state, changed: [.state])
    }
    
    func audioPlayer(_ audioPlayer: AudioPlayer, shouldStartPlaying item: AudioItem) -> Bool {
        return true
    }
    
    func audioPlayer(_ audioPlayer: AudioPlayer, willStartPlaying item: AudioItem) {
        /// do something
    }
    
    func audioPlayer(_ audioPlayer: AudioPlayer, didUpdateProgressionTo time: TimeInterval, percentageRead: Float) {
        self.state.progressionTo = time.toSeconds()
        self.state.percentage = percentageRead
        ///reset
        if percentageRead >= 99 {
            state.percentage = 0
            state.progressionTo = 0
        }
        emit(playbackNotfication: .All, state: self.state, changed: [.percentage, .progressionTo])
    }
    
    func audioPlayer(_ audioPlayer: AudioPlayer, didFindDuration duration: TimeInterval, for item: AudioItem) {
        self.state.duration = DurationValue(display: "\(duration.toSeconds()) s", seconds: duration.toSeconds())
        emit(playbackNotfication: .All, state: self.state, changed: [.duration])
    }
    
    func audioPlayer(_ audioPlayer: AudioPlayer, didUpdateEmptyMetadataOn item: AudioItem, withData data: Metadata) {
        /// do something
    }
    
    func audioPlayer(_ audioPlayer: AudioPlayer, didLoad range: TimeRange, for item: AudioItem) {
        /// do something
    }
}
