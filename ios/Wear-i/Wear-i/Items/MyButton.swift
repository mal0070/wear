//
//  Buttons.swift
//  Wear-i
//
//  Created by 이민아 on 2023/01/12.
//

import UIKit
import Foundation

//Custom Button
class MyButton: UIButton {
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String, bgColor: UIColor, titleColor: UIColor){
        //보조 이니셜라이저 - 미리 값을 지정
        self.init()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: 350).isActive = true
        self.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 18.0)
        self.layer.cornerRadius = 3.0
        
        self.setTitle(title, for: .normal)
        self.backgroundColor = bgColor
        self.setTitleColor(titleColor, for: .normal)
    }
}

