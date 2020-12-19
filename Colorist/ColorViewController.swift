//
//  ViewController.swift
//  Colorist
//
//  Created by Максим Соловьёв on 04.12.2020.
//

import UIKit

protocol ColorViewControllerDelegate: class {
    
    func colorViewController(_ viewController: ColorViewController, didSelectColor: UIColor)
    
}

class ColorViewController: UIViewController, UITextFieldDelegate {
    
    weak var delegate: ColorViewControllerDelegate?
    
    let colorView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 125
        view.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        view.layer.borderWidth = 3
        return view
    }()
    
    let redSwitch: UISwitch = {
        let switcher = UISwitch()
        switcher.onTintColor = .systemRed
        switcher.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
        return switcher
    }()
    
    let greenSwitch: UISwitch = {
        let switcher = UISwitch()
        switcher.onTintColor = .systemGreen
        switcher.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
        return switcher
    }()
    
    let blueSwitch: UISwitch = {
        let switcher = UISwitch()
        switcher.onTintColor = .systemBlue
        switcher.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
        return switcher
    }()
    
    let redSlider: UISlider = {
        let slider = UISlider()
        slider.tintColor = .systemRed
        slider.minimumValue = 0
        slider.maximumValue = 255
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        return slider
    }()
    
    let greenSlider: UISlider = {
        let slider = UISlider()
        slider.tintColor = .systemGreen
        slider.minimumValue = 0
        slider.maximumValue = 255
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        return slider
    }()
    
    let blueSlider: UISlider = {
        let slider = UISlider()
        slider.tintColor = .systemBlue
        slider.minimumValue = 0
        slider.maximumValue = 255
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        return slider
    }()
    
    let redTextField = CustomTextField()
    let greenTextField = CustomTextField()
    let blueTextField = CustomTextField()
    let whiteButton = CustomActionButton()
    let blackButton = CustomActionButton()
    let randomButton = CustomActionButton()
    let resetButton = CustomActionButton()
        
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        title = "Цвет"
        
        self.redTextField.delegate = self
        self.greenTextField.delegate = self
        self.blueTextField.delegate = self
        
        setupTextFields()
        setupButtons()
        setupConstraints()
        setupNavigationController()
        addButtonsOnKeyboard()
        
        redTextField.setupPlaceholder(text: "RED")
        greenTextField.setupPlaceholder(text: "GREEN")
        blueTextField.setupPlaceholder(text: "BLUE")
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @objc func didSelectColor(_ color: UIColor) {
        let color = colorView.backgroundColor!
        delegate?.colorViewController(self, didSelectColor: color)
        self.navigationController?.popViewController(animated: true)
        
    }
    
    private func updateColor() {
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue:CGFloat = 0
        var textRed = ""
        var textGreen = ""
        var textBlue = ""
        
        if redSwitch.isOn {
            red = CGFloat(redSlider.value)
            textRed = String(lroundf(redSlider.value))
        }
        if greenSwitch.isOn {
            green = CGFloat(greenSlider.value)
            textGreen = String(lroundf(greenSlider.value))
        }
        if blueSwitch.isOn {
            blue = CGFloat(blueSlider.value)
            textBlue = String(lroundf(blueSlider.value))
        }
        
        let color = UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
        colorView.backgroundColor = color
        redTextField.text = textRed
        greenTextField.text = textGreen
        blueTextField.text = textBlue
    }
    
    @objc func switchValueChanged(_ sender: UISwitch) {
        updateColor()
    }
    
    @objc func sliderValueChanged(_ sender: UISlider) {
        updateColor()
    }

    
    @objc func didTapWhiteButton() {
        colorView.backgroundColor = .clear
        redSwitch.isOn = true
        greenSwitch.isOn = true
        blueSwitch.isOn = true
        redSlider.value = 255
        greenSlider.value = 255
        blueSlider.value = 255
        updateColor()
    }
    
    @objc func didTapBlackButton() {
        colorView.backgroundColor = .clear
        redSwitch.isOn = true
        greenSwitch.isOn = true
        blueSwitch.isOn = true
        redSlider.value = 0
        greenSlider.value = 0
        blueSlider.value = 0
        updateColor()
    }
    
    @objc func didTapRandomButton() {
        colorView.backgroundColor = .clear
        redSwitch.isOn = true
        greenSwitch.isOn = true
        blueSwitch.isOn = true
        redSlider.value = Float.random(in: 0...255)
        blueSlider.value = Float.random(in: 0...255)
        greenSlider.value = Float.random(in: 0...255)
        updateColor()
    }
    
    @objc func didTapResetButton() {
        colorView.backgroundColor = .clear
        redTextField.text = ""
        greenTextField.text = ""
        blueTextField.text = ""
        redTextField.placeholder = "RED"
        greenTextField.placeholder = "GREEN"
        blueTextField.placeholder = "BLUE"
        redSwitch.isOn = false
        greenSwitch.isOn = false
        blueSwitch.isOn = false
        redSlider.value = 0.0
        greenSlider.value = 0.0
        blueSlider.value = 0.0
    }
    
    private func addButtonsOnKeyboard() {
        let doneToolbarRed: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbarRed.barStyle = .default
        let doneToolbarGreen: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbarGreen.barStyle = .default
        let doneToolbarBlue: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbarBlue.barStyle = .default
        
        
        let flexSpaceRed = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneRed: UIBarButtonItem = UIBarButtonItem(title: "Pick GREEN", style: .done, target: self, action: #selector(self.redButtonAction))
        let flexSpaceGreen = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneGreen: UIBarButtonItem = UIBarButtonItem(title: "Pick BLUE", style: .done, target: self, action: #selector(self.greenButtonAction))
        let flexSpaceBlue = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBlue: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.blueButtonAction))
        
        let itemsRed = [flexSpaceRed, doneRed]
        doneToolbarRed.items = itemsRed
        doneToolbarRed.sizeToFit()
        redTextField.inputAccessoryView = doneToolbarRed
        
        let itemsGreen = [flexSpaceGreen, doneGreen]
        doneToolbarGreen.items = itemsGreen
        doneToolbarGreen.sizeToFit()
        greenTextField.inputAccessoryView = doneToolbarGreen
        
        let itemsBlue = [flexSpaceBlue, doneBlue]
        doneToolbarBlue.items = itemsBlue
        doneToolbarBlue.sizeToFit()
        blueTextField.inputAccessoryView = doneToolbarBlue
    }
    
    @objc func redButtonAction(){
        greenTextField.becomeFirstResponder()
    }
    
    @objc func greenButtonAction(){
        blueTextField.becomeFirstResponder()
    }
    
    @objc func blueButtonAction(){
        blueTextField.resignFirstResponder()
        self.view.endEditing(true)
        colorView.backgroundColor = .clear
        redSwitch.isOn = true
        greenSwitch.isOn = true
        blueSwitch.isOn = true
        let redColor = Float(redTextField.text ?? "")
        let greenColor = Float(greenTextField.text ?? "")
        let blueColor = Float(blueTextField.text ?? "")
        redSlider.value = redColor ?? 0
        greenSlider.value = greenColor ?? 0
        blueSlider.value = blueColor ?? 0
        updateColor()
    }
    
    private func setupTextFields() {
        redTextField.placeholder = "RED"
        greenTextField.placeholder = "GREEN"
        blueTextField.placeholder = "BLUE"
    }
    
    private func setupButtons() {
        whiteButton.setupButtonTitle(text: "WHITE", color: .lightGray)
        whiteButton.addTarget(self, action: #selector(didTapWhiteButton), for: .touchUpInside)
        blackButton.setupButtonTitle(text: "BLACK", color: .lightGray)
        blackButton.addTarget(self, action: #selector(didTapBlackButton), for: .touchUpInside)
        randomButton.setupButtonTitle(text: "RANDOM", color: .lightGray)
        randomButton.addTarget(self, action: #selector(didTapRandomButton), for: .touchUpInside)
        resetButton.setupButtonTitle(text: "RESET", color: .systemOrange)
        resetButton.addTarget(self, action: #selector(didTapResetButton), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        
        view.addSubview(colorView)
        view.addSubview(randomButton)
        view.addSubview(resetButton)
        view.addSubview(whiteButton)
        view.addSubview(blackButton)
        view.addSubview(blueSwitch)
        view.addSubview(blueTextField)
        view.addSubview(blueSlider)
        view.addSubview(greenSwitch)
        view.addSubview(greenTextField)
        view.addSubview(greenSlider)
        view.addSubview(redSwitch)
        view.addSubview(redTextField)
        view.addSubview(redSlider)
        
        [colorView,
         randomButton,
         resetButton,
         whiteButton,
         blackButton,
         blueSwitch,
         blueTextField,
         blueSlider,
         greenSwitch,
         greenTextField,
         greenSlider,
         redSwitch,
         redTextField,
         redSlider].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        
        NSLayoutConstraint.activate([
            colorView.heightAnchor.constraint(equalToConstant: 250),
            colorView.widthAnchor.constraint(equalToConstant: 250),
            colorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            colorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            randomButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            randomButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),            randomButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -5),
            randomButton.heightAnchor.constraint(equalToConstant: 80),
            randomButton.widthAnchor.constraint(equalToConstant: 170)
        ])
        
        NSLayoutConstraint.activate([
            resetButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            resetButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 5),
            resetButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            resetButton.heightAnchor.constraint(equalToConstant: 80),
            resetButton.widthAnchor.constraint(equalToConstant: 170)
        ])
        
        NSLayoutConstraint.activate([
            whiteButton.bottomAnchor.constraint(equalTo: randomButton.topAnchor, constant: -10),
            whiteButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            whiteButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -5),
            whiteButton.heightAnchor.constraint(equalToConstant: 80),
            whiteButton.widthAnchor.constraint(equalToConstant: 170)
        ])
        
        NSLayoutConstraint.activate([
            blackButton.bottomAnchor.constraint(equalTo: resetButton.topAnchor, constant: -10),
            blackButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 5),
            blackButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            blackButton.heightAnchor.constraint(equalToConstant: 80),
            blackButton.widthAnchor.constraint(equalToConstant: 170)
        ])
        
        NSLayoutConstraint.activate([
            blueSwitch.bottomAnchor.constraint(equalTo: whiteButton.topAnchor, constant: -20),
            blueSwitch.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            blueSwitch.heightAnchor.constraint(equalToConstant: 30),
            blueSwitch.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            blueTextField.bottomAnchor.constraint(equalTo: whiteButton.topAnchor, constant: -20),
            blueTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5),
            blueTextField.heightAnchor.constraint(equalToConstant: 30),
            blueTextField.widthAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            blueSlider.bottomAnchor.constraint(equalTo: whiteButton.topAnchor, constant: -20),
            blueSlider.leadingAnchor.constraint(equalTo: blueSwitch.trailingAnchor, constant: 30),
            blueSlider.trailingAnchor.constraint(equalTo: blueTextField.leadingAnchor, constant: -20),
            blueSlider.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            greenSwitch.bottomAnchor.constraint(equalTo: blueSwitch.topAnchor, constant: -20),
            greenSwitch.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            greenSwitch.heightAnchor.constraint(equalToConstant: 30),
            greenSwitch.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            greenTextField.bottomAnchor.constraint(equalTo: blueTextField.topAnchor, constant: -20),
            greenTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5),
            greenTextField.heightAnchor.constraint(equalToConstant: 30),
            greenTextField.widthAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            greenSlider.bottomAnchor.constraint(equalTo: blueSlider.topAnchor, constant: -20),
            greenSlider.leadingAnchor.constraint(equalTo: greenSwitch.trailingAnchor, constant: 30),
            greenSlider.trailingAnchor.constraint(equalTo: greenTextField.leadingAnchor, constant: -20),
            greenSlider.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            redSwitch.bottomAnchor.constraint(equalTo: greenSwitch.topAnchor, constant: -20),
            redSwitch.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            redSwitch.heightAnchor.constraint(equalToConstant: 30),
            redSwitch.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            redTextField.bottomAnchor.constraint(equalTo: greenTextField.topAnchor, constant: -20),
            redTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5),
            redTextField.heightAnchor.constraint(equalToConstant: 30),
            redTextField.widthAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            redSlider.bottomAnchor.constraint(equalTo: greenSlider.topAnchor, constant: -20),
            redSlider.leadingAnchor.constraint(equalTo: redSwitch.trailingAnchor, constant: 30),
            redSlider.trailingAnchor.constraint(equalTo: redTextField.leadingAnchor, constant: -20),
            redSlider.heightAnchor.constraint(equalToConstant: 30)
        ])

    }
    
    private func setupNavigationController() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        let editButton: UIButton = {
            let button = UIButton()
            button.setImage(UIImage(named: "edit"), for: .normal)
            button.sizeToFit()
            button.addTarget(self, action: #selector(didSelectColor), for: .touchUpInside)
            return button
        }()
        
        let editButtonItem: UIBarButtonItem = UIBarButtonItem(customView: editButton)
        self.navigationItem.rightBarButtonItem = editButtonItem
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard redTextField.text != "" || greenTextField.text != "" || blueTextField.text != "" else { return }
        self.view.endEditing(true)
        colorView.backgroundColor = .clear
        redSwitch.isOn = true
        greenSwitch.isOn = true
        blueSwitch.isOn = true
        let redColor = Float(redTextField.text ?? "")
        let greenColor = Float(greenTextField.text ?? "")
        let blueColor = Float(blueTextField.text ?? "")
        redSlider.value = redColor ?? 0
        greenSlider.value = greenColor ?? 0
        blueSlider.value = blueColor ?? 0
        updateColor()
    }
    
}
