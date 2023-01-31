//
//  WeatherSectionView.swift
//  Wear-i
//
//  Created by 이민아 on 2023/01/23.
//

import SnapKit
import UIKit

final class WeatherSectionView: UIView {
    //MARK: Property
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = UIColor(named: "w_background")
        collectionView.showsHorizontalScrollIndicator = false //스크롤바 숨김
        
        collectionView.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: "WeatherCollectionViewCell")

        return collectionView
    }()
    
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview()
            $0.height.equalTo(230)
            $0.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



extension WeatherSectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: frame.width-40.0, height: frame.height / 4)
    }
    
    //셀 클릭 -> frame을 애니메이션 객체에 넘겨줌
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
}

extension WeatherSectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCollectionViewCell", for: indexPath) as? WeatherCollectionViewCell
        cell?.setup()
        return cell ?? UICollectionViewCell()
    }
    
    
    
}
