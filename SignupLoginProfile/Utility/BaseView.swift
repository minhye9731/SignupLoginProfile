//
//  BaseView.swift
//  SignupLoginProfile
//
//  Created by 강민혜 on 11/2/22.
//

import UIKit
import SnapKit

class BaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configureUI() { }
    
    func setConstraints() { }
    
}
