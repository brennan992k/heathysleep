//
//  FadeOutPickerView.swift
//  healthysleep
//
//  Created by Mac on 30/06/2021.
//

import UIKit

protocol FadeOutPickerViewDelegate {
    func didSelect(_ picker: FadeOutPickerView, value: FadeValue)
}

class FadeOutPickerView: UIView {
    
    var delegate: FadeOutPickerViewDelegate?
    
    private var data = [FadeValue]()
    
    private let picker: UIPickerView = {
        let picker = UIPickerView()
        
        return picker
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.data = WhitenoiseData.shared.fadeValues
        addSubview(picker)
        picker.dataSource = self
        picker.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        picker.frame = CGRect(x: 0, y: 0, width: width, height: height)
    }
}

extension FadeOutPickerView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let value = data[row]
        self.delegate?.didSelect(self, value: value)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let fadeOut = data[row]
        return fadeOut.display
    }
}
