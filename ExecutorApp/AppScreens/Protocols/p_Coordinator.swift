//
//  p_Coordinator.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 22.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

protocol Coordinator {

    var navigationController: UINavigationController { get set }

    func start()
}
