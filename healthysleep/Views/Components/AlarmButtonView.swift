//
//  AlarmButtonView.swift
//  healthysleep
//
//  Created by Mac on 30/06/2021.
//

import UIKit

protocol AlarmButtonViewDelegate {
    func didTapAlarmButton(_ view: AlarmButtonView)
    func didChangeAlarm(_ view: AlarmButtonView, value: Date)
}

enum AlarmButtonViewIdentifier {
    case SelectionAlert
}

class AlarmButtonView: UIView {
    
    
    
    var delegate: AlarmButtonViewDelegate?

    private var alarmButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        let image = UIImage(systemName: "clock", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
        button.setImage(image, for: .normal)
        return button
    }()
    
    private var valueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "", size: 10)
        label.textColor = .systemPink
        label.textAlignment = .center
        label.text = ""
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(alarmButton)
        addSubview(valueLabel)
        alarmButton.addTarget(self, action: #selector(didTapAlarmButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        alarmButton.frame = CGRect(x: 0, y: 0, width: width, height: height)
        valueLabel.frame = CGRect(x: 0, y: alarmButton.bottom + 5, width: width, height: height)
    }
    
    func updateUIWith(state: PlaybackState, changed: [PSField]) {
        valueLabel.text = state.alarm?.description
    }
    
    @objc func didTapAlarmButton() {
        delegate?.didTapAlarmButton(self)
    }
    
    func dequeueAlert(_ identifier: AlarmButtonViewIdentifier) -> UIAlertController {
        switch identifier {
        case .SelectionAlert:
            let alertView = UIAlertController(
                title: "Time",
                message: "",
                preferredStyle: .alert
            )
            let vc = UIViewController()
            vc.preferredContentSize = CGSize(width: 100,height: 60)
            let timePicker = UIDatePicker()
            timePicker.datePickerMode = .time
            timePicker.frame = CGRect(x: 0, y: 0, width: 100, height: 60)
            vc.view.addSubview(timePicker)
            alertView.setValue(vc, forKey: "contentViewController")
            alertView.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
            alertView.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                self.delegate?.didChangeAlarm(self, value: timePicker.date)
            }))
            return alertView
        }
        
    }
}
