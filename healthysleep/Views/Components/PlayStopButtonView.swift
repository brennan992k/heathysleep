//
//  PlayStopButtonView.swift
//  healthysleep
//
//  Created by Mac on 30/06/2021.
//

import UIKit

protocol PlayStopButtonViewDelegate {
    func didTapPlay(_ view: PlayStopButtonView, completion: ((Bool) -> Void)?)
    func didTapStop(_ view: PlayStopButtonView, completion: ((Bool) -> Void)?)
}

class PlayStopButtonView: UIView {
    
    var delegate: PlayStopButtonViewDelegate?
    
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .center
        return nameLabel
    }()
    
    private let durationSlider: DurationSliderView = {
        let durationSlider = DurationSliderView()
        return durationSlider
    }()
    
    
    
    private let playButton: UIButton = {
        let button = UIButton()
        button.setTitle("Play", for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }()
    
    private let stopButton: UIButton = {
        let button = UIButton()
        button.setTitle("Stop", for: .normal)
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(playButton)
        addSubview(stopButton)
        
        playButton.addTarget(self, action: #selector(didTapPlay), for: .touchUpInside)
        stopButton.addTarget(self, action: #selector(didTapStop), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let spacing: CGFloat = 10
        playButton.frame = CGRect(x: spacing, y: 0, width:(width - spacing * 3)/2, height: height )
        stopButton.frame = CGRect(x: playButton.right + spacing, y: playButton.top, width:(width - spacing * 3)/2, height: height )
      
    }
    
    func updateUIWith(state: PlaybackState, changed: [PSField]) {
        if state.state.isPlaying && !state.state.isPaused{
            playButton.backgroundColor = .systemPink
            stopButton.backgroundColor = .red
        } else {
            playButton.backgroundColor = .red
            stopButton.backgroundColor = .systemPink
        }
    }
    
    @objc func didTapPlay () {
        delegate?.didTapPlay(self, completion: nil)
    }
    
    @objc func didTapStop() {
        delegate?.didTapStop(self, completion: nil)
    }

}
