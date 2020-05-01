//
//  SelfSizingTableView.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 25.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class SelfSizingTableView: UITableView {

    override var intrinsicContentSize: CGSize {
      return contentSize
    }

    override func reloadData() {
      super.reloadData()
      invalidateIntrinsicContentSize()
    }

}
