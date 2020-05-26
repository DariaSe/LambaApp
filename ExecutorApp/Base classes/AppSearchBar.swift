//
//  AppSearchBar.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 23.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class AppSearchBar: UISearchBar {
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        searchBarStyle = .prominent
        placeholder = Strings.search
        autocapitalizationType = .none
        autocorrectionType = .no
        enablesReturnKeyAutomatically = true
        if let textField = self.value(forKey: "searchField") as? UITextField {
            textField.backgroundColor = UIColor.textControlsBackgroundColor
            textField.clearButtonMode = .whileEditing
        }
    }
}


