//
//  EventsTableViewCell.swift
//  RomArte
//
//  Created by Claudio Segoloni on 05/01/16.
//  Copyright © 2016 RomArte. All rights reserved.
//

import UIKit

class EventsTableViewCell: UITableViewCell {
    
    // MARK: Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
