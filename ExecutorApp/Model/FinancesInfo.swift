//
//  FinancesInfo.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 25.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import Foundation

struct FinancesInfo {
    var readyToTransferUnits: [ReadyToTransferUnit?]
    var sum: String
    var notReadySum: String
    var isAllowedToTransfer: Bool
    var transferDescription: String
    
    static func sample() -> FinancesInfo {
        return FinancesInfo(readyToTransferUnits: [ReadyToTransferUnit(title: "Video", sum: "2000"), ReadyToTransferUnit(title: "Promo", sum: "4000"), ReadyToTransferUnit(title: "Order", sum: "15000")], sum: "21000", notReadySum: "8000", isAllowedToTransfer: true, transferDescription: "Some description")
    }
    
    static func initialize(from dictionary: [String : Any]) -> FinancesInfo? {
        guard let financeReadyList = dictionary["financeReadyList"] as? [[String : Any]],
            let totalToWithdraw = dictionary["totalToWithdraw"] as? Int,
            let totalUnfinishedOrders = dictionary["totalUnfinishedOrders"] as? Int
            else { return nil }
        let units = financeReadyList.map { ReadyToTransferUnit.initialize(from: $0) }
        let financesInfo = FinancesInfo(readyToTransferUnits: units, sum: totalToWithdraw.string, notReadySum: totalUnfinishedOrders.string, isAllowedToTransfer: !units.isEmpty, transferDescription: "Some description")
        return financesInfo
    }
}

struct ReadyToTransferUnit {
    var title: String
    var sum: String
    
    static func initialize(from dictionary: [String : Any]) -> ReadyToTransferUnit? {
        guard let sum = dictionary["sum"] as? Int,
            let title = dictionary["title"] as? String
            else { return nil }
        let unit = ReadyToTransferUnit(title: title, sum: sum.string)
        return unit
    }
}

