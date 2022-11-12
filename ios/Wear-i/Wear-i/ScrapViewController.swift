//
//  ScrapViewController.swift
//  Wear-i
//
//  Created by 이민아 on 2022/11/13.
//

import UIKit

class ScrapViewController: UIViewController {
    // MARK: - Init: Lazy 사용위해(메모리 절약)
    convenience init(bgColor: UIColor) {
        self.init()
        self.view.backgroundColor = bgColor
    }

    override func viewDidLoad() {
        let label = UILabel(frame: CGRect(x:100, y:200, width: 200, height: 100))
        label.text = "Scrap"
        label.sizeToFit() //자동으로 레이블 크기 조정 (글자 생략 없이 표현 가능)
        label.center.x = self.view.frame.width/2
        
        self.view.addSubview(label)
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }


}

