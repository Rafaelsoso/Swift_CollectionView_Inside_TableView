//
//  Cell.swift
//  CollectionViewTag_InsideTableViewCell
//
//  Created by anh.nguyen3 on 13/11/24.
//

import UIKit

class Cell: UITableViewCell {

    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    var didheightConstraintUpdated: (() -> Void)?

    override func layoutSubviews() {
        super.layoutSubviews()
        updateCollectionViewHeight()
    }

    func reloadData() {
        collectionView.reloadData()
        collectionView.layoutIfNeeded()
        updateCollectionViewHeight()
    }

    private func updateCollectionViewHeight() {
        let contentSize = collectionView.collectionViewLayout.collectionViewContentSize
        if collectionViewHeightConstraint.constant != contentSize.height {
            collectionViewHeightConstraint.constant = contentSize.height
            layoutIfNeeded()
            didheightConstraintUpdated?()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

}
