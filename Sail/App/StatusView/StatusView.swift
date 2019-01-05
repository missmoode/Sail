//
//  StatusView.swift
//  Sail
//
//  Created by Amy Harris on 26/10/2018.
//  Copyright © 2018 Amelia Harris. All rights reserved.
//

import UIKit

class StatusView: UIView {

    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    
    @IBOutlet weak var bodyView: UIView!
    
    @IBOutlet var bodyTextView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        
        Bundle.main.loadNibNamed("StatusView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        //if content type is just text
        bodyView.addSubview(bodyTextView)
    }
    
    
}
