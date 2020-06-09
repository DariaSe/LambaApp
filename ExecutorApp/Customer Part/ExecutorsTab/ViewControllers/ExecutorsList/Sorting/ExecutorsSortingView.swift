//
//  ExecutorsSortingView.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 03.06.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class ExecutorsSortingView: UIView {
    
    var sortingOptions: [String] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var selectedOptionIndex: Int = 0 {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var didSelectOption: ((String) -> Void)?
    
    lazy var collectionView: UICollectionView = {
        return UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewLayout)
    }()
    
    let collectionViewLayout = UICollectionViewFlowLayout()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        collectionView.pinToEdges(to: self)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionViewLayout.scrollDirection = .horizontal
        collectionView.indicatorStyle = .white
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: -10, right: 0)
        collectionView.register(SortingCollectionViewCell.self, forCellWithReuseIdentifier: SortingCollectionViewCell.reuseIdentifier)
        collectionView.backgroundColor = .clear
    }
}

extension ExecutorsSortingView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sortingOptions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SortingCollectionViewCell.reuseIdentifier, for: indexPath) as! SortingCollectionViewCell
        let text = sortingOptions[indexPath.row]
        let isSelected = indexPath.row == selectedOptionIndex
        cell.update(text: text, isSelected: isSelected)
        return cell
    }
}

extension ExecutorsSortingView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let string = sortingOptions[indexPath.row]
        let width = string.width(withConstrainedHeight: 13, font: UIFont.systemFont(ofSize: 13)) + 38
        return CGSize(width: width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
}

extension ExecutorsSortingView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectOption?(sortingOptions[indexPath.row])
        selectedOptionIndex = indexPath.row
    }
}
