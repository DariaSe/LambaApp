//
//  FinancesInfo.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 25.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import Foundation

struct FinancesInfo {
    var readyToTransferUnits: [ReadyToTransferUnit]
    var sum: String
    var notReadySum: String
    var isAllowedToTransfer: Bool
    
    static func sample() -> FinancesInfo {
        return FinancesInfo(readyToTransferUnits: [ReadyToTransferUnit(title: "Video", sum: "2000"), ReadyToTransferUnit(title: "Promo", sum: "4000"), ReadyToTransferUnit(title: "Order", sum: "15000")], sum: "21000", notReadySum: "8000", isAllowedToTransfer: true)
    }
}

struct ReadyToTransferUnit {
    var title: String
    var sum: String
}

