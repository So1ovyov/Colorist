//
//  CustomUI.swift
//  Colorist
//
//  Created by Максим Соловьёв on 06.12.2020.
//

import Foundation
import UIKit

class CustomActionButton : UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

   private func setup() {
    translatesAutoresizingMaskIntoConstraints = false
    layer.borderWidth = 1
    layer.cornerRadius = 10
    layer.masksToBounds = true
    setTitleColor(.black, for: .normal)
    titleLabel?.font = UIFont(name: "Copperplate", size: 20)
    }
    
    func setupButtonTitle(text: String, color: UIColor) {
        self.setTitle(text, for: .normal)
        self.backgroundColor = color
    }
}

class CustomLabel : UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

   private func setup() {
    translatesAutoresizingMaskIntoConstraints = false
    font = UIFont(name: "Copperplate", size: 16)
    textColor = .black
    lineBreakMode = .byWordWrapping
    numberOfLines = 0
    sizeToFit()
    backgroundColor = .clear
    textAlignment = .center
    }
    
    func setupTextLabel(textLabel: String) {
        self.text = textLabel
    }
}
