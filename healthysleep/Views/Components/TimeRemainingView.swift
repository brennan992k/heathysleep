//
//  TimeRemainingView.swift
//  healthysleep
//
//  Created by Mac on 30/06/2021.
//

import UIKit

class TimeRemainingView: UIView {
    private let timeRemaining: UILabel = {
        let timeRemaining = UILabel()
        timeRemaining.text = "Time Remaining 0:00:30"
        timeRemaining.textAlignment = .center
        return timeRemaining
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(timeRemaining)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        timeRemaining.frame = CGRect(x: 0, y: 0, width: width, height: height)
    }
    
    func updateUIWith(state: PlaybackState, changed: [PSField]) {
        let seconds = state.timeRemaining
        hmsFrom(seconds: Int(seconds)) { hours, minutes, seconds in
            let hours = getStringFrom(seconds: hours)
            let minutes = getStringFrom(seconds: minutes)
            let seconds = getStringFrom(seconds: seconds)

            self.timeRemaining.text = "Time Remaining \(hours):\(minutes):\(seconds)"
        }
    }
    
}
