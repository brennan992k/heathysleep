//
//  SoundControl.swift
//  healthysleep
//
//  Created by Mac on 25/06/2021.
//

import UIKit

protocol SoundControlDelegate: AnyObject{
    func soundControlDidTapPlay(_ soundControl: SoundControl)
    func soundControlDidTapPause(_ soundControl: SoundControl)
    func soundControlDidChangeDuration(_ soundControl: SoundControl, value: Float)
    func soundControlDidChangeVolume(_ soundControl: SoundControl, value: Float)
}

class SoundControl: UIView {
    
    weak var delegate: SoundControlDelegate?
    
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.numberOfLines = 1
        nameLabel.font = UIFont(name:"" , size: 18)
        return nameLabel
    }()
    
    private let volumeSlider: UISlider  = {
        let volumeSlider = UISlider()
        volumeSlider.value = 0.5
        return volumeSlider
    }()
    
    private let durationSlider: UISlider  = {
        let volumeSlider = UISlider()
        volumeSlider.value = 0.5
        return volumeSlider
    }()
    
    private let playButton: UIButton = {
        let playButton = UIButton()
        
        return playButton
    }()
    
    private let pauseButton: UIButton = {
        let pauseButton = UIButton()
        return pauseButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(volumeSlider)
        addSubview(durationSlider)
        addSubview(nameLabel)
        addSubview(playButton)
        addSubview(pauseButton)
        
        durationSlider.addTarget(self, action: #selector(didChangeDuration), for: .valueChanged)
        volumeSlider.addTarget(self, action: #selector(didVolumeChanged), for: .valueChanged)
        playButton.addTarget(self, action: #selector(playSound), for: .touchUpInside)
        pauseButton.addTarget(self, action: #selector(pauseSound), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    @objc func didChangeDuration(_ slider: UISlider) {
        let value = slider.value
        delegate?.soundControlDidChangeDuration(self, value: value)
    }
    
    @objc func didVolumeChanged(_ slider: UISlider) {
        let value = slider.value
        delegate?.soundControlDidChangeVolume(self, value: value)
    }
    
    @objc func playSound () {
        delegate?.soundControlDidTapPlay(self)
    }
    
    @objc func pauseSound () {
        delegate?.soundControlDidTapPause(self)
    }
    
}
