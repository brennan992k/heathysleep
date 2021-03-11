//
//  DurationSliderView.swift
//  healthysleep
//
//  Created by Mac on 27/06/2021.
//

import UIKit


protocol DurationSliderViewDelegate {
    func didChangeDuration (_ durationSliderView: DurationSliderView, value: DurationValue, completion: ((Bool) -> Void)?)
}

class DurationSliderView: UIView {
    
    var delegate:  DurationSliderViewDelegate?
    
    private let slider: UISlider = {
        let slider = UISlider()
        return slider
    }()
    
    private let icon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(systemName: "note")
        return icon
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Duration"
        label.font = UIFont(name: "", size: 12)
        return label
    }()
    
    private let value: UILabel = {
        let label = UILabel()
        label.text = "30s"
        label.font = UIFont(name: "", size: 12)
        label.textAlignment = .right
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(slider)
        addSubview(icon)
        addSubview(label)
        addSubview(label)
        addSubview(value)
        slider.addTarget(self, action: #selector(didChangeDuration), for: .valueChanged)
        let durationValues = WhitenoiseData.shared.durationValues
        self.slider.minimumValue = 0
        self.slider.maximumValue = durationValues.count > 1 ? Float(durationValues.count - 1) : 1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        icon.frame = CGRect(x: 0, y: 0, width: 10, height: 20)
        label.frame = CGRect(x: icon.right + 5, y: icon.top, width: 100, height: 20)
        value.frame = CGRect(x: width - 100, y: icon.top , width: 100, height: 20)
        slider.frame = CGRect(x: 0, y: icon.bottom + 10, width: width, height: height - 20)
    }
    
    @objc func didChangeDuration (slider: UISlider) {
        let step: Float = 1
        let index = Int(round(slider.value / step) * step)
        let durationValues = WhitenoiseData.shared.durationValues
        guard index >= 0 && index < durationValues.count else {
            return
        }
        let durationValue = durationValues[index]
        DispatchQueue.main.async {
            self.value.text = durationValue.display
        }
        self.delegate?.didChangeDuration(self, value: durationValue, completion: nil)
    }
    
    func updateUIWith(state: PlaybackState, changed: [PSField]) {
        
    }

}
