//
//  MenuAccount.swift
//  Sail
//
//  Created by Amy Harris on 04/11/2018.
//  Copyright © 2018 Amelia Harris. All rights reserved.
//

import Foundation
import UIKit

class MenuAccountView: UIView, Themed {
    func applyTheme(theme: Theme) {
        displayNameView.textColor = theme.primaryTintForegroundColor
        acctView.textColor = theme.primaryTintForegroundColor
        avatarView.backgroundColor = theme.primaryTintForegroundColor
    }
    
    var account: AppAccount? {
        didSet {
            if let account = account {
                acctView.text = account.acct
                displayNameView.text = account.displayName
                avatarView.kf.setImage(with: account.avatar)
            }
        }
    }
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var displayNameView: UILabel!
    @IBOutlet weak var acctView: UILabel!
    @IBOutlet weak var avatarView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("MenuAccountView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        avatarView.makeRounded()
    }
    
    override func awakeFromNib() {
        setUpThemeing()
    }
}
