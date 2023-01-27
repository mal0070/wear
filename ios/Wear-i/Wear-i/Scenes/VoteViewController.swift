//
//  VoteViewController.swift
//  Wear-i
//
//  Created by 이민아 on 2022/11/13.
//

import UIKit

class VoteViewController: UIViewController {
    // MARK: - Init: Lazy 사용위해(메모리 절약)
    convenience init(bgColor: UIColor) {
        self.init()
        self.view.backgroundColor = bgColor
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
    }
    
    //MARK: Custom NavigationBar
    func setupNavigationBar(){
        let title = UILabel()
        title.text = "PICK"
        title.textColor = .white
        title.font = UIFont(name: "Pretendard-ExtraBold", size: 30)
        title.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: title)
        
        let addButton = UIBarButtonItem(title: nil, image: UIImage(systemName: "plus.app"), target: self, action: #selector(addVote))
        navigationItem.rightBarButtonItem = addButton
        addButton.tintColor = .white
       
      
    }
    
    //MARK: Animation
    @objc func addVote(){
            
        }


}

