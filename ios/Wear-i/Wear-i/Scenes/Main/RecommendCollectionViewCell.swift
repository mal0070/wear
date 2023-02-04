//
//  RecommendCollectionViewCell.swift
//  Wear-i
//
//  Created by 이민아 on 2023/01/23.
//

import SnapKit
import UIKit
import Kingfisher
import Alamofire

final class RecommendCollectionViewCell : UICollectionViewCell {
    
    lazy var clothImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .lightGray
        
        return imageView
    }()
    
    private lazy var userLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "w_orange")
        label.font = UIFont(name: "Pretendard-Bold", size: 18.0)
        return label
    }()
    
    private lazy var bookmarkButton : UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(bookmarkPressed), for: .touchUpInside)
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        button.tintColor  = .white
        return button
    }()
    
    @objc func bookmarkPressed(_ sender: UIButton) {
        if bookmarkButton.imageView?.image == UIImage(systemName: "bookmark.fill"){
            bookmarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
            bookmarkButton.tintColor = .white
        } else if bookmarkButton.imageView?.image == UIImage(systemName: "bookmark"){
            bookmarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            bookmarkButton.tintColor = .white
        }
    }
    
    func setup(){
        setupLayout()
        userLabel.text = "사용자 정보"
        
        
        
    }
}

private extension RecommendCollectionViewCell {
    func setupLayout(){
        [clothImageView,userLabel,bookmarkButton].forEach{addSubview($0)}
        
        clothImageView.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(4.0)
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview().inset(30.0)
            $0.trailing.equalToSuperview()
        }
        userLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(4.0)
            $0.top.equalTo(clothImageView.snp.bottom).offset(4.0)
        }
        bookmarkButton.snp.makeConstraints{
            $0.top.equalTo(userLabel.snp.top)
            $0.trailing.equalToSuperview().inset(4.0)
        }
        
    }
}


