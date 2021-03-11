//
//  SoundControlView.swift
//  healthysleep
//
//  Created by Mac on 27/06/2021.
//

import UIKit

protocol SoundControlViewDelegate {
    func didTapPlay(_ controllView: SoundControlView, completion: ((Bool) -> Void)?)
    func didTapStop(_ controllView: SoundControlView, completion: ((Bool) -> Void)?)
    func didChangeDuration(_ controllView: SoundControlView, value: DurationValue, completion: ((Bool) -> Void)?)
    func didChangeVolume(_ controllView: SoundControlView, value: Float, completion: ((Bool) -> Void)?)
}

class SoundControlView: UIView {
    
    var delegate: SoundControlViewDelegate?
    
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .center
        return nameLabel
    }()
    
    private let durationSlider = DurationSliderView()
    private let timeRemaining = TimeRemainingView()
    private let playStopButton = PlayStopButtonView()
    private let volumeSlider = VolumeSliderView()
     
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(nameLabel)
        addSubview(durationSlider)
        addSubview(volumeSlider)
        addSubview(playStopButton)
        addSubview(timeRemaining)
        durationSlider.delegate = self
        volumeSlider.delegate = self
        playStopButton.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let spacing: CGFloat = 10
        nameLabel.frame = CGRect(x: 0, y: spacing, width: width - spacing * 2, height: 30)
        durationSlider.frame = CGRect(x: spacing, y: nameLabel.bottom + spacing, width:width - spacing * 2, height: 50 )
        volumeSlider.frame = CGRect(x: spacing, y: durationSlider.bottom + spacing, width:width - spacing * 2, height: 50 )
        playStopButton.frame = CGRect(x: 0, y: volumeSlider.bottom + spacing, width: width, height: 50 )
        timeRemaining.frame = CGRect(x: spacing, y: playStopButton.bottom + spacing, width: width - spacing * 2, height: 50 )
    }
    
    func updateUIWith(state: PlaybackState, changed: [PSField]) {
        if let soundName = state.sound?.name,  changed.contains(.sound) {
            nameLabel.text = soundName
        }
        if changed.contains(.duration) {
           durationSlider.updateUIWith(state: state, changed: changed)
        }
        if changed.contains(.state) {
            playStopButton.updateUIWith(state: state, changed: changed)
        }
        if changed.contains(.duration) || changed.contains(.progressionTo) || changed.contains(.percentage) {
            timeRemaining.updateUIWith(state: state, changed: changed)
        }
    }
}

extension SoundControlView: DurationSliderViewDelegate {
    func didChangeDuration (_ durationSliderView: DurationSliderView, value: DurationValue, completion: ((Bool) -> Void)?) {
        delegate?.didChangeDuration(self, value: value, completion: completion)
    }
}

extension SoundControlView: VolumeSliderViewDelegate {
    func didChangeVolume(_ view: VolumeSliderView, value: Float, completion: ((Bool) -> Void)?) {
        delegate?.didChangeVolume(self, value: value, completion: completion)
    }
}

extension SoundControlView: PlayStopButtonViewDelegate {
    func didTapPlay(_ view: PlayStopButtonView, completion: ((Bool) -> Void)?) {
        delegate?.didTapPlay(self, completion: completion)
    }
    
    func didTapStop(_ view: PlayStopButtonView, completion: ((Bool) -> Void)?) {
        delegate?.didTapStop(self, completion: completion)
    }
}
