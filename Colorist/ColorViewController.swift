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
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.layer.cornerRadius = 125
        view.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        view.layer.borderWidth = 3
        return view
    }()
    
    let redSwitch: UISwitch = {
        let switcher = UISwitch()
        switcher.translatesAutoresizingMaskIntoConstraints = false
        switcher.onTintColor = .systemRed
        switcher.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
        return switcher
    }()
    
    let greenSwitch: UISwitch = {
        let switcher = UISwitch()
        switcher.translatesAutoresizingMaskIntoConstraints = false
        switcher.onTintColor = .systemGreen
        switcher.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
        return switcher
    }()
    
    let blueSwitch: UISwitch = {
        let switcher = UISwitch()
        switcher.translatesAutoresizingMaskIntoConstraints = false
        switcher.onTintColor = .systemBlue
        switcher.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
        return switcher
    }()
    
    let redSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.tintColor = .systemRed
        slider.minimumValue = 0
        slider.maximumValue = 255
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        return slider
    }()
    
    let greenSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.tintColor = .systemGreen
        slider.minimumValue = 0
        slider.maximumValue = 255
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        return slider
    }()
    
    let blueSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.tintColor = .systemBlue
        slider.minimumValue = 0
        slider.maximumValue = 255
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        return slider
    }()
    
    let redTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.text = ""
        tf.placeholder = "RED"
        tf.textAlignment = .center
        tf.backgroundColor = .white
        return tf
    }()
    
    let greenTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.text = ""
        tf.placeholder = "GREEN"
        tf.textAlignment = .center
        tf.backgroundColor = .white
        return tf
    }()
    
    let blueTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.text = ""
        tf.placeholder = "BLUE"
        tf.textAlignment = .center
        tf.backgroundColor = .white
        tf.returnKeyType = .done
        return tf
    }()
    
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
        colorView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        colorView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        colorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        colorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        
        view.addSubview(randomButton)
        randomButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        randomButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        randomButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -5).isActive = true
        randomButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        randomButton.widthAnchor.constraint(equalToConstant: 170).isActive = true
        
        view.addSubview(resetButton)
        resetButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        resetButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 5).isActive = true
        resetButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        resetButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        resetButton.widthAnchor.constraint(equalToConstant: 170).isActive = true
        
        view.addSubview(whiteButton)
        whiteButton.bottomAnchor.constraint(equalTo: randomButton.topAnchor, constant: -10).isActive = true
        whiteButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        whiteButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -5).isActive = true
        whiteButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        whiteButton.widthAnchor.constraint(equalToConstant: 170).isActive = true
        
        view.addSubview(blackButton)
        blackButton.bottomAnchor.constraint(equalTo: resetButton.topAnchor, constant: -10).isActive = true
        blackButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 5).isActive = true
        blackButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        blackButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        blackButton.widthAnchor.constraint(equalToConstant: 170).isActive = true
        
        view.addSubview(blueSwitch)
        blueSwitch.bottomAnchor.constraint(equalTo: whiteButton.topAnchor, constant: -20).isActive = true
        blueSwitch.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        blueSwitch.heightAnchor.constraint(equalToConstant: 30).isActive = true
        blueSwitch.widthAnchor.constraint(equalToConstant: 40).isActive = true

        view.addSubview(blueTextField)
        blueTextField.bottomAnchor.constraint(equalTo: whiteButton.topAnchor, constant: -20).isActive = true
        blueTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        blueTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        blueTextField.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        view.addSubview(blueSlider)
        blueSlider.bottomAnchor.constraint(equalTo: whiteButton.topAnchor, constant: -20).isActive = true
        blueSlider.leadingAnchor.constraint(equalTo: blueSwitch.trailingAnchor, constant: 30).isActive = true
        blueSlider.trailingAnchor.constraint(equalTo: blueTextField.leadingAnchor, constant: -20).isActive = true
        blueSlider.heightAnchor.constraint(equalToConstant: 30).isActive = true

        view.addSubview(greenSwitch)
        greenSwitch.bottomAnchor.constraint(equalTo: blueSwitch.topAnchor, constant: -20).isActive = true
        greenSwitch.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        greenSwitch.heightAnchor.constraint(equalToConstant: 30).isActive = true
        greenSwitch.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        view.addSubview(greenTextField)
        greenTextField.bottomAnchor.constraint(equalTo: blueTextField.topAnchor, constant: -20).isActive = true
        greenTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        greenTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        greenTextField.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        view.addSubview(greenSlider)
        greenSlider.bottomAnchor.constraint(equalTo: blueSlider.topAnchor, constant: -20).isActive = true
        greenSlider.leadingAnchor.constraint(equalTo: greenSwitch.trailingAnchor, constant: 30).isActive = true
        greenSlider.trailingAnchor.constraint(equalTo: greenTextField.leadingAnchor, constant: -20).isActive = true
        greenSlider.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        view.addSubview(redSwitch)
        redSwitch.bottomAnchor.constraint(equalTo: greenSwitch.topAnchor, constant: -20).isActive = true
        redSwitch.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        redSwitch.heightAnchor.constraint(equalToConstant: 30).isActive = true
        redSwitch.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        view.addSubview(redTextField)
        redTextField.bottomAnchor.constraint(equalTo: greenTextField.topAnchor, constant: -20).isActive = true
        redTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        redTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        redTextField.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        view.addSubview(redSlider)
        redSlider.bottomAnchor.constraint(equalTo: greenSlider.topAnchor, constant: -20).isActive = true
        redSlider.leadingAnchor.constraint(equalTo: redSwitch.trailingAnchor, constant: 30).isActive = true
        redSlider.trailingAnchor.constraint(equalTo: redTextField.leadingAnchor, constant: -20).isActive = true
        redSlider.heightAnchor.constraint(equalToConstant: 30).isActive = true
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == redTextField {
            greenTextField.becomeFirstResponder()
        } else if textField == greenTextField {
            blueTextField.becomeFirstResponder()
        } else if textField == blueTextField {
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
        return false
    }
    
    
    
}