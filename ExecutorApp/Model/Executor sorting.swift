//
//  Executor sorting.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 15.06.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import Foundation

enum SortingOrder: String {
    case popularity = "byPopularity"
    case orders = "byOrders"
    case new = "byNovelty"
    case favorites = "byFavorites"
}

enum SortingDirection: String {
    case ascending = "asc"
    case descending = "desc"
}

struct SortingOption {
    var title: String
    var sortingOrder: SortingOrder
    var sortingDirection: SortingDirection
    var isSelected: Bool
    
    mutating func toggleSortingDirection() {
        self.sortingDirection = sortingDirection == .descending ? .ascending : .descending
    }
    
    static func defaultOptions() -> [SortingOption] {
        let popular = SortingOption(title: Strings.popularityOption, sortingOrder: .popularity, sortingDirection: .descending, isSelected: true)
        let orders = SortingOption(title: Strings.ordersOption, sortingOrder: .orders, sortingDirection: .descending, isSelected: false)
        let new = SortingOption(title: Strings.newOption, sortingOrder: .new, sortingDirection: .descending, isSelected: false)
        let favorites = SortingOption(title: Strings.favoritesOption, sortingOrder: .favorites, sortingDirection: .descending, isSelected: false)
        return [popular, orders, new, favorites]
    }
}
