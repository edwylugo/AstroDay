//
//  DatePickerViewController.swift
//  AstroDay
//
//  Created by Edwy Lugo on 02/02/25.
//

import UIKit

class DatePickerViewController: UIViewController {
    
    var onDateSelected: ((String) -> Void)?
    
    let datePicker = UIDatePicker().apply {
        $0.datePickerMode = .date
        $0.preferredDatePickerStyle = .wheels
        $0.maximumDate = Date()
    }
    
    let selectButton = UIButton(type: .system).apply {
        $0.setTitle(Strings.button_text_ok, for: .normal)
    }
    
    let cancelButton = UIButton(type: .system).apply {
        $0.setTitle(Strings.button_text_cancel, for: .normal)
    }
    
    let stackView = UIStackView(translateMask: false).apply {
        $0.axis = .vertical
        $0.spacing = 12
        $0.alignment = .center
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    @objc func selectDate() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let selectedDate = formatter.string(from: datePicker.date)
        onDateSelected?(selectedDate)
        dismiss(animated: true)
    }
    
    @objc func dismissModal() {
        dismiss(animated: true)
    }
}

extension DatePickerViewController: CodeView {
    func buildViewHierarchy() {
        view.addSubview(stackView)
        stackView.addArrangedSubviews([datePicker, selectButton, cancelButton])
    }
    
    func setupConstraints() {
        stackView.centerX(inView: view)
        stackView.centerY(inView: view)
        stackView.setWidth(width: 300)
    }
    
    func setupAdditionalConfiguration() {
        view.backgroundColor = .black
        view.layer.cornerRadius = 12
        selectButton.addTarget(self, action: #selector(selectDate), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(dismissModal), for: .touchUpInside)
    }
}
