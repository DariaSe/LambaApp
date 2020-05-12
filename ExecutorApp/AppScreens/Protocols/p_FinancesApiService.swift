//
//  p_FinancesApiService.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 25.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import Foundation

protocol FinancesApiService {
    func getFinances(completion: @escaping (FinancesInfo?, String?) -> Void)
    func getTransferDescription(completion: @escaping (String?, String?) -> Void)
    func transferMoney(completion: @escaping (Bool, String?) -> Void)
}
