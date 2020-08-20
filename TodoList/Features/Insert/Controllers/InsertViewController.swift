//
//  InsertViewController.swift
//  TodoList
//
//  Created by tamires.p.silva on 19/08/20.
//  Copyright © 2020 Tamires. All rights reserved.
//

import UIKit

final class InsertViewController: UIViewController {
    
    @IBOutlet weak var tagView: UIView!
    @IBOutlet weak var backButton: CircleButton!
    @IBOutlet weak var todoField: UITextField!
    @IBOutlet weak var typePicker: UIPickerView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var saveButton: CircleButton!
    
    private var selectedType: Tasks.ModelType = .onPriority {
        didSet {
            configureColor()
        }
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        configureColor(animated: false)
        configureTextField()
        configureButton()
        configuteTypePicker()
    }
}

extension InsertViewController {
    private func configureTextField() {
        todoField.borderStyle = .none
    }
    
    private func configureButton() {
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .primaryActionTriggered)
        saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .primaryActionTriggered)
    }
    
    private func configuteTypePicker() {
        typePicker.delegate = self
        typePicker.dataSource = self
    }
    
    private func configureColor(animated: Bool = true) {
        if animated {
            UIView.animate(withDuration: 0.3) {
                self.backButton.backgroundColor = self.selectedType.typeColor
                self.tagView.backgroundColor = self.selectedType.typeColor
                self.saveButton.backgroundColor = self.selectedType.typeColor
            }
        }  else {
            backButton.backgroundColor = selectedType.typeColor
            tagView.backgroundColor = selectedType.typeColor
            saveButton.backgroundColor = selectedType.typeColor
        }
    }
}

extension InsertViewController {
    @objc
    private func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func saveButtonPressed() {
        guard let text = todoField.text else {
            return
        }
        
        let model = Tasks(type: selectedType, descTask: text, date: datePicker.date)
        TodoDataSource.share.todos.append(model)
        navigationController?.popViewController(animated: true)
        
    }
}

extension InsertViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Tasks.ModelType.types.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Tasks.ModelType.types[row].typeDescription
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedType = Tasks.ModelType.types[row]
        
    }
    
}
