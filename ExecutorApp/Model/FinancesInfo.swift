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
            let totalUnfinishedOrders = dictionary["totalUnfinishedOrders"] as? Int,
            let transferDescription = dictionary["transferDescription"] as? String
            else { return nil }
        let units = financeReadyList.map(ReadyToTransferUnit.initialize)
        let sign = InfoService.shared.userInfo?.currencySign ?? ""
        let sum = sign == "₽" ? totalToWithdraw.string + sign : sign + totalToWithdraw.string
        let notReadySum = sign == "₽" ? totalUnfinishedOrders.string + sign : sign + totalUnfinishedOrders.string
        let financesInfo = FinancesInfo(readyToTransferUnits: units, sum: sum, notReadySum: notReadySum, isAllowedToTransfer: !units.isEmpty, transferDescription: transferDescription)
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
        let sign = InfoService.shared.userInfo?.currencySign ?? ""
        let sumString = sign == "₽" ? sum.string + sign : sign + sum.string
        let unit = ReadyToTransferUnit(title: title, sum: sumString)
        return unit
    }
}

