//
//  ColorViewController.swift
//  Colorist
//
//  Created by Максим Соловьёв on 18.12.2020.
//

import UIKit

class StartViewController: UIViewController, UINavigationControllerDelegate  {
    
    let editButton = CustomActionButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        setupCustomUI()
        setupConstraints()
    }
    
    private func setupCustomUI() {
        editButton.setupButtonTitle(text: "ЦВЕТ", color: .white)
        editButton.addTarget(self, action: #selector(didTapChangeColorButton), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        
        view.addSubview(editButton)
        
        editButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            editButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            editButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            editButton.heightAnchor.constraint(equalToConstant: 40),
            editButton.widthAnchor.constraint(equalToConstant: 140)
        ])
    }
    
    @objc func didTapChangeColorButton() {
        let vc = ColorViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.delegate = self
        vc.colorView.backgroundColor = view.backgroundColor
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension StartViewController: ColorViewControllerDelegate {
    
    func colorViewController(_ viewController: ColorViewController, didSelectColor: UIColor) {
        view.backgroundColor = didSelectColor
    }
    
}
