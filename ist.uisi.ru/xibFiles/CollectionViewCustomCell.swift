//
//  CollectionViewCustomCell.swift
//  ist.uisi.ru
//
//  Created by Александр Фарносов on 28.09.2020.
//  Copyright © 2020 Александр Фарносов. All rights reserved.
//

import UIKit

class CollectionViewCustomCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBOutlet weak var imagePost: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
