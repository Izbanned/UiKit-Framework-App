//
//  ViewController.swift
//  UiKitTest
//
//  Created by Dias Karimov on 18.08.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var switchLabel: UISwitch!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var switchTitle: UILabel!
    
    var uiElements = ["UISegmentedControl",
    "UISlider", "UILabel", "UITextField", "UIDatePicker", "UIButton"]
    
    var selectedElement: String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        label.textAlignment = .center
        label.numberOfLines = 0
        slider.value = 1
        slider.minimumValue = 1
        slider.maximumValue = 100
        slider.thumbTintColor = .red
        slider.minimumTrackTintColor = .green
        slider.maximumTrackTintColor = .blue
        slider.minimumTrackImage(for: .normal)
        slider.maximumTrackImage(for: .normal)
        label.numberOfLines = 2
        label.font = label.font.withSize(20)
        
        datePicker.locale = Locale(identifier: "ru_RU")
        
        
        choiceUiElement()
        createToolBarButton()
    }
    
    func createToolBarButton() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissKeyboard))
        
        toolbar.setItems([doneButton], animated: true)
        toolbar.isUserInteractionEnabled = true
        
        textField.inputAccessoryView = toolbar
        
        
        toolbar.tintColor = .white
        toolbar.barTintColor = .brown
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func hideAllElemets() {
        segment.isHidden = true
        slider.isHidden = true
        label.isHidden = true
        datePicker.isHidden = true
        button.isHidden = true
    }
    
    func choiceUiElement() {
        var elementPicker = UIPickerView()
        elementPicker.delegate = self
        textField.inputView = elementPicker
        elementPicker.backgroundColor = .brown
        
    }
    
    

    @IBAction func sliderChanged(_ sender: UISlider) {
//        label.text = String(slider.value)
       
    }
    
    
    
    @IBAction func segmentSelected(_ sender: UISegmentedControl) {
        switch segment.selectedSegmentIndex {
        case 0:
            label.textColor = .blue
        case 1:
            label.textColor = .red
        default:
            label.textColor = .black
        }
    }
    
    @IBAction func pressedButton(_ sender: UIButton) {
        
        guard textField.text?.isEmpty == false else  { return }
        
        if let _ = Double(textField.text!) {
            let alert = UIAlertController(title: "Wrong format", message: "Enter the correct name", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
            textField.text = nil
        } else {
            label.text = textField.text
            textField.text = nil
        }
        
        
        
        
    }
    
    @IBAction func changeDate(_ sender: UIDatePicker) {
        let dateFormat = DateFormatter()
        dateFormat.dateStyle = .full
        let dateValue = dateFormat.string(from: sender.date)
        label.text =   dateValue
    }
    @IBAction func switchCheck(_ sender: UISwitch) {
        segment.isHidden = !segment.isHidden
        slider.isHidden = !slider.isHidden
        label.isHidden = !label.isHidden
        textField.isHidden = !textField.isHidden
        datePicker.isHidden = !datePicker.isHidden
        button.isHidden = !button.isHidden
        
        if sender.isOn == false {
            switchTitle.text = "Отобразить все "
        } else {
            switchTitle.text = "Скрыть все"
        }
    }
}


extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate  {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return uiElements.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return uiElements[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedElement = uiElements[row]
        textField.text = selectedElement
        
        switch row {
        case 0:
            hideAllElemets()
            segment.isHidden = false
        case 1:
            hideAllElemets()
            slider.isHidden = false
        case 2:
            hideAllElemets()
            label.isHidden = false
        case 3:
            hideAllElemets()
        case 4:
            hideAllElemets()
            datePicker.isHidden = false
        case 5:
            hideAllElemets()
            button.isHidden = false
        default: hideAllElemets()
        }
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerViewLabel = UILabel()
        if let currentLabel = view as? UILabel {
            pickerViewLabel = currentLabel
        } else {
            pickerViewLabel = UILabel()
        }
        
        pickerViewLabel.textColor = .white
        pickerViewLabel.textAlignment = .center
        pickerViewLabel.font = UIFont(name: "AppleSDGgothicNeo-Regular", size: 23)
         pickerViewLabel.text = uiElements[row]
        return pickerViewLabel
    }
                                      

    
}
