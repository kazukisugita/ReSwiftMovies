//
//  DiscoveryListViewCell.swift
//  WarpFactorIOS
//
//  Created by Thibault Wittemberg on 18-04-09.
//  Copyright (c) RxSwiftCommunity. All rights reserved.
//

import UIKit

final class MovieListViewCell: UITableViewCell {

    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var overview: UILabel!

    override func prepareForReuse() {
        self.imageView?.image = nil
    }
}
