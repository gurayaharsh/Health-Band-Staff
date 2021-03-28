//
//  PatientTableViewCell.swift
//  Health Band Staff
//
//  Created by Joshua George on 2021-02-06.
//  Copyright © 2021 Harsh Guraya. All rights reserved.
//

import UIKit

class PatientTableViewCell: UITableViewCell {
    
    @IBOutlet var myLabel: UILabel!
    @IBOutlet var roundView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
