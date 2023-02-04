//
//  ProfileDataView.swift
//  Wear-i
//
//  Created by 이민아 on 2023/01/31.
//

import SnapKit
import UIKit

final class ProfileDataView: UIView {
    private let title: String
    private let count: Int
        
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-Medium", size: 14.0)
        label.text = title
        label.textColor = .white

        return label
    }()
    
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-Bold", size: 16.0)
        label.text = "\(count)"
        label.textColor = .white
           
        return label
    }()
    
    init(title: String, count: Int){
        self.title = title
        self.count = count
        
        super.init(frame: .zero)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension ProfileDataView {
    func setupLayout() {
        let stackView = UIStackView(arrangedSubviews: [countLabel, titleLabel])
        stackView.axis = .vertical //방향
        stackView.alignment = .center //정렬
        stackView.spacing = 4.0
        
        addSubview(stackView)
        stackView.snp.makeConstraints{ $0.edges.equalToSuperview()}
    }
}
