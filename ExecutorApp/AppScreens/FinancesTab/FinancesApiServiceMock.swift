//
//  FinancesApiServiceMock.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 25.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import Foundation

class FinancesApiServiceMock: FinancesApiService {
    
    var isTransfered: Bool = false
    
    func getFinances(completion: @escaping (FinancesInfo?, Error?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if !self.isTransfered {
                completion(FinancesInfo.sample(), nil)
                self.isTransfered = true
            }
            else {
                completion(FinancesInfo(readyToTransferUnits: [], sum: "0", notReadySum: "8000", isAllowedToTransfer: false), nil)
            }
        }
    }
    
    func getTransferDescription(completion: @escaping (String?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            completion("Some transfer description")
        }
    }
    
    func transferMoney(completion: @escaping (Bool) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            completion(true)
        }
    }
    
    
}
