//
//  VenueCell.swift
//  FourSquareSampleApp
//
//  Created by Khristoffer Julio on 18/09/2018.
//  Copyright © 2018 Khristoffer Julio. All rights reserved.
//

import UIKit

class VenueCell: UITableViewCell {
    static var reuseIdentifier: String {
        return "venue_cell_identifier"
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: VenueCell.reuseIdentifier)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textLabel?.adjustsFontSizeToFitWidth = true
        textLabel?.minimumScaleFactor = 0.1
        
        detailTextLabel?.adjustsFontSizeToFitWidth = true
        detailTextLabel?.minimumScaleFactor = 0.1
        detailTextLabel?.numberOfLines = 2
    }
    
    // limit to these two informations as this is what we only needs
    func configure(name: String, distance: Int) {
        self.textLabel?.text = name
        self.detailTextLabel?.text = "Distance: \(distance) meters"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // make sure cells are clean when reusing
        self.textLabel?.text = ""
        self.detailTextLabel?.text = ""
    }
}
