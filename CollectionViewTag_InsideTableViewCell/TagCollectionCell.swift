//
//  TagCollectionCell.swift
//  CollectionViewTag_InsideTableViewCell
//
//  Created by anh.nguyen3 on 13/11/24.
//

import UIKit

class TagCollectionCell: UICollectionViewCell {

    @IBOutlet weak var title: UILabel!

    override var intrinsicContentSize: CGSize {
        return CGSize(width: self.title.intrinsicContentSize.width + 40.0, height: 45) // 40: horizontal padding
    }
}
