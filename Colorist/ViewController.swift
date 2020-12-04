//
//  ViewController.swift
//  Colorist
//
//  Created by Максим Соловьёв on 04.12.2020.
//

import UIKit

class ViewController: UIViewController {
    
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
        switcher.addTarget(self, action: #selector(redSwitchValueChanged), for: .valueChanged)
        return switcher
    }()
    
    let greenSwitch: UISwitch = {
        let switcher = UISwitch()
        switcher.translatesAutoresizingMaskIntoConstraints = false
        switcher.onTintColor = .systemGreen
        switcher.addTarget(self, action: #selector(greenSwitchValueChanged), for: .valueChanged)
        return switcher
    }()
    
    let blueSwitch: UISwitch = {
        let switcher = UISwitch()
        switcher.translatesAutoresizingMaskIntoConstraints = false
        switcher.onTintColor = .systemBlue
        switcher.addTarget(self, action: #selector(blueSwitchValueChanged), for: .valueChanged)
        return switcher
    }()
    
    let redSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.tintColor = .systemRed
        slider.addTarget(self, action: #selector(redSliderValueChanged), for: .valueChanged)
        return slider
    }()
    
    let greenSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.tintColor = .systemGreen
        slider.addTarget(self, action: #selector(greenSliderValueChanged), for: .valueChanged)
        return slider
    }()
    
    let blueSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.tintColor = .systemBlue
        slider.addTarget(self, action: #selector(blueSliderValueChanged), for: .valueChanged)
        return slider
    }()
    
    let whiteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .lightGray
        button.layer.borderWidth = 1
        button.setTitle("WHITE", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Copperplate", size: 20)
        button.addTarget(self, action: #selector(didTapWhiteButton), for: .touchUpInside)
        return button
    }()
    
    let blackButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .lightGray
        button.layer.borderWidth = 1
        button.setTitle("BLACK", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Copperplate", size: 20)
        button.addTarget(self, action: #selector(didTapBlackButton), for: .touchUpInside)
        return button
    }()
    
    let randomButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .lightGray
        button.layer.borderWidth = 1
        button.setTitle("RANDOM", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Copperplate", size: 20)
        button.addTarget(self, action: #selector(didTapRandomButton), for: .touchUpInside)
        return button
    }()
    
    let resetButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemOrange
        button.layer.borderWidth = 1
        button.setTitle("RESET", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Copperplate", size: 20)
        button.addTarget(self, action: #selector(didTapResetButton), for: .touchUpInside)
        return button
    }()
    
    let redLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "RED"
        label.font = UIFont(name: "Copperplate", size: 16)
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.sizeToFit()
        label.backgroundColor = .clear
        label.textAlignment = .center
        return label
    }()
    
    let greenLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "GREEN"
        label.font = UIFont(name: "Copperplate", size: 16)
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.sizeToFit()
        label.backgroundColor = .clear
        label.textAlignment = .center
        return label
    }()
    
    let blueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "BLUE"
        label.font = UIFont(name: "Copperplate", size: 16)
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.sizeToFit()
        label.backgroundColor = .clear
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        setupConstraints()
    }
    
    func updateColor() {
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue:CGFloat = 0
        var textRed = ""
        var textGreen = ""
        var textBlue = ""
        
        if redSwitch.isOn {
            red = CGFloat(redSlider.value)
            textRed = String(redSlider.value)
        }
        if greenSwitch.isOn {
            green = CGFloat(greenSlider.value)
            textGreen = String(greenSlider.value)
        }
        if blueSwitch.isOn {
            blue = CGFloat(blueSlider.value)
            textBlue = String(blueSlider.value)
        }
        
        let color = UIColor(red: red, green: green, blue: blue, alpha: 1)
        colorView.backgroundColor = color
        redLabel.text = textRed
        greenLabel.text = textGreen
        blueLabel.text = textBlue
    }
    
    @objc func redSwitchValueChanged(_ sender: UISwitch) {
        updateColor()
    }
    
    @objc func greenSwitchValueChanged(_ sender: UISwitch) {
        updateColor()
    }
    
    @objc func blueSwitchValueChanged(_ sender: UISwitch) {
        updateColor()
    }
    
    @objc func redSliderValueChanged(_ sender: UISlider) {
        updateColor()
    }
    
    @objc func greenSliderValueChanged(_ sender: UISlider) {
        updateColor()
    }
    
    @objc func blueSliderValueChanged(_ sender: UISlider) {
        updateColor()
    }
    
    @objc func didTapWhiteButton() {
        colorView.backgroundColor = .clear
        redSwitch.isOn = true
        greenSwitch.isOn = true
        blueSwitch.isOn = true
        redSlider.value = 1.0
        greenSlider.value = 1.0
        blueSlider.value = 1.0
        updateColor()
    }
    
    @objc func didTapBlackButton() {
        colorView.backgroundColor = .clear
        redSwitch.isOn = true
        greenSwitch.isOn = true
        blueSwitch.isOn = true
        redSlider.value = 0.0
        greenSlider.value = 0.0
        blueSlider.value = 0.0
        updateColor()
    }
    
    @objc func didTapRandomButton() {
        colorView.backgroundColor = .clear
        redSwitch.isOn = true
        greenSwitch.isOn = true
        blueSwitch.isOn = true
        redSlider.value = Float.random(in: 0.0...1.0)
        blueSlider.value = Float.random(in: 0.0...1.0)
        greenSlider.value = Float.random(in: 0.0...1.0)
        updateColor()
    }
    
    @objc func didTapResetButton() {
        colorView.backgroundColor = .clear
        redSwitch.isOn = false
        greenSwitch.isOn = false
        blueSwitch.isOn = false
        redSlider.value = 0.0
        greenSlider.value = 0.0
        blueSlider.value = 0.0
    }
    
    func setupConstraints() {
        
        view.addSubview(colorView)
        colorView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        colorView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        colorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        colorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        
        view.addSubview(redSwitch)
        redSwitch.topAnchor.constraint(equalTo: colorView.bottomAnchor, constant: 20).isActive = true
        redSwitch.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        redSwitch.heightAnchor.constraint(equalToConstant: 30).isActive = true
        redSwitch.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        view.addSubview(greenSwitch)
        greenSwitch.topAnchor.constraint(equalTo: redSwitch.bottomAnchor, constant: 20).isActive = true
        greenSwitch.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        greenSwitch.heightAnchor.constraint(equalToConstant: 30).isActive = true
        greenSwitch.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        view.addSubview(blueSwitch)
        blueSwitch.topAnchor.constraint(equalTo: greenSwitch.bottomAnchor, constant: 20).isActive = true
        blueSwitch.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        blueSwitch.heightAnchor.constraint(equalToConstant: 30).isActive = true
        blueSwitch.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        view.addSubview(redLabel)
        redLabel.topAnchor.constraint(equalTo: colorView.bottomAnchor, constant: 20).isActive = true
        redLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        redLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        redLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        view.addSubview(greenLabel)
        greenLabel.topAnchor.constraint(equalTo: redLabel.bottomAnchor, constant: 20).isActive = true
        greenLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        greenLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        greenLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        view.addSubview(blueLabel)
        blueLabel.topAnchor.constraint(equalTo: greenLabel.bottomAnchor, constant: 20).isActive = true
        blueLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        blueLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        blueLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        view.addSubview(redSlider)
        redSlider.topAnchor.constraint(equalTo: colorView.bottomAnchor, constant: 20).isActive = true
        redSlider.leadingAnchor.constraint(equalTo: redSwitch.trailingAnchor, constant: 30).isActive = true
        redSlider.trailingAnchor.constraint(equalTo: redLabel.leadingAnchor, constant: -20).isActive = true
        redSlider.heightAnchor.constraint(equalToConstant: 30).isActive = true

        view.addSubview(greenSlider)
        greenSlider.topAnchor.constraint(equalTo: redSlider.bottomAnchor, constant: 20).isActive = true
        greenSlider.leadingAnchor.constraint(equalTo: greenSwitch.trailingAnchor, constant: 30).isActive = true
        greenSlider.trailingAnchor.constraint(equalTo: greenLabel.leadingAnchor, constant: -20).isActive = true
        greenSlider.heightAnchor.constraint(equalToConstant: 30).isActive = true

        view.addSubview(blueSlider)
        blueSlider.topAnchor.constraint(equalTo: greenSlider.bottomAnchor, constant: 20).isActive = true
        blueSlider.leadingAnchor.constraint(equalTo: blueSwitch.trailingAnchor, constant: 30).isActive = true
        blueSlider.trailingAnchor.constraint(equalTo: blueLabel.leadingAnchor, constant: -20).isActive = true
        blueSlider.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        view.addSubview(whiteButton)
        whiteButton.topAnchor.constraint(equalTo: blueSwitch.bottomAnchor, constant: 30).isActive = true
        whiteButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        whiteButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -5).isActive = true
        whiteButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        whiteButton.widthAnchor.constraint(equalToConstant: 170).isActive = true
        
        view.addSubview(blackButton)
        blackButton.topAnchor.constraint(equalTo: blueSwitch.bottomAnchor, constant: 30).isActive = true
        blackButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 5).isActive = true
        blackButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        blackButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        blackButton.widthAnchor.constraint(equalToConstant: 170).isActive = true
        
        view.addSubview(randomButton)
        randomButton.topAnchor.constraint(equalTo: whiteButton.bottomAnchor, constant: 10).isActive = true
        randomButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        randomButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -5).isActive = true
        randomButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        randomButton.widthAnchor.constraint(equalToConstant: 170).isActive = true
        
        view.addSubview(resetButton)
        resetButton.topAnchor.constraint(equalTo: blackButton.bottomAnchor, constant: 10).isActive = true
        resetButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 5).isActive = true
        resetButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        resetButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        resetButton.widthAnchor.constraint(equalToConstant: 170).isActive = true
    }
    
}

