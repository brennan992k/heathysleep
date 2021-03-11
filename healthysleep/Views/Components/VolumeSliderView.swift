//
//  VolumeSliderView.swift
//  healthysleep
//
//  Created by Mac on 30/06/2021.
//

import UIKit

protocol VolumeSliderViewDelegate {
    func didChangeVolume(_ view: VolumeSliderView, value: Float, completion: ((Bool) -> Void)?)
}

class VolumeSliderView: UIView {
    
    var delegate: VolumeSliderViewDelegate?

    private let volumeSlider: UISlider = {
        let volumeSlider = UISlider()
        volumeSlider.minimumValueImage = UIImage(systemName: "speaker.fill")
        volumeSlider.maximumValueImage = UIImage(systemName: "speaker.wave.2.fill")
        volumeSlider.thumbTintColor = .systemPink
        volumeSlider.value = 0.3
        return volumeSlider
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(volumeSlider)
        volumeSlider.addTarget(self, action: #selector(didChangeValue(slider:)), for: .valueChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
       
        volumeSlider.frame = CGRect(x: 0, y: 0, width:width, height:height )
    }
    
    func updateUIWith(state: PlaybackState, changed: [PSField]) {
        
    }
    
    @objc func didChangeValue (slider: UISlider) {
        let value = slider.value
        delegate?.didChangeVolume(self, value: value,completion: nil)
    }
        
}
