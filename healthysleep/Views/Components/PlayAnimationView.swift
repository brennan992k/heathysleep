//
//  StatusPlayerViewBarItem.swift
//  healthysleep
//
//  Created by Mac on 28/06/2021.
//

import UIKit
import Lottie

class PlayAnimationView: UIView {
    
    private var state: PlaybackState?
    
    private var animationView: AnimationView = {
        let animationView = AnimationView(name: "playing_anim_st")
        animationView.contentMode = .scaleAspectFit
        return animationView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(animationView)
        PlaybackPresenter.shared.on(self, selector: #selector(onState), playbackNotfication: .State)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .red
        animationView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        animationView.center = self.center
        animationView.loopMode = .loop
        animationView.isHidden = true
    }
    
    @objc private func onState(_ notfication: Notification) {
        guard let state = notfication.userInfo?["state"] as? PlaybackState else {
            return
        }
        self.state = state
        updateUI()
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        updateUI()
    }
    
    private func updateUI() {
        guard let state = state else {
            return
        }
        switch state.state {
        case .buffering:
            animationView.isHidden = false
        case .paused:
            animationView.stop()
        case .playing:
            animationView.play()
        case .stopped:
            animationView.isHidden = true
        case .waitingForConnection:
            animationView.isHidden = true
        case .failed(_):
            animationView.isHidden = true
        }
    }
    
    
    
}
