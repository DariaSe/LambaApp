//
//  InputFormViewController.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 21.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class InputFormViewController: UIViewController, KeyboardHandler {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let stackView = UIStackView()
  
    let inputFormView = InputFormView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerForKeyboardNotifications(for: scrollView)
        view.backgroundColor = UIColor.backgroundColor
        
        scrollView.pinToEdges(to: view)
        contentView.center(in: scrollView)
        contentView.setWidth(equalTo: view)
       
        stackView.pinToEdges(to: contentView)
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 40
        stackView.distribution = .equalSpacing
        
        stackView.addArrangedSubview(inputFormView)
        inputFormView.setWidth(equalTo: view, multiplier: 0.8)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.contentSize = CGSize(width: contentView.bounds.width, height: view.bounds.height - view.layoutMargins.top - view.layoutMargins.bottom - 44)
    }
    
    func add(_ textField: FormTextField) {
        inputFormView.add(textField: textField)
    }
    
    func add(_ button: UIButton) {
        inputFormView.add(button: button)
    }
    
    func addToTop(_ view: UIView) {
        stackView.insertArrangedSubview(view, at: 0)
    }
    
    func addToBottom(_ view: UIView) {
        stackView.addArrangedSubview(view)
    }
}
