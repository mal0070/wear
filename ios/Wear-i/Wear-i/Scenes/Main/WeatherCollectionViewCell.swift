//
//  WeatherCollectionViewCell.swift
//  Wear-i
//
//  Created by 이민아 on 2023/01/25.
//

import SnapKit
import UIKit

final class WeatherCollectionViewCell : UICollectionViewCell {
    //MARK: Property
    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-Bold", size: 17.0)
        label.textColor = .lightGray
        return label
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-ExtraBold", size: 40.0)
        label.textColor = .white
        return label
    }()
    
    private var mainIcon = UIImageView(image: UIImage(named: "흐림"))
    
    private lazy var recommendLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-Medium", size: 20.0)
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()
    
    func setup(){
        setupLayout()
        
        locationLabel.text = "광진구"
        temperatureLabel.text="15°"
        recommendLabel.text = "오늘은 일교차가 커요.\n외투 챙겨 나가세요!"
    }
    
}

private extension WeatherCollectionViewCell {
    func setupLayout() {
        [locationLabel, temperatureLabel, mainIcon, recommendLabel].forEach{addSubview($0)}
        
        locationLabel.snp.makeConstraints{
            $0.top.equalToSuperview().inset(16.0)
            $0.centerX.equalToSuperview()
            //$0.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
        }
        mainIcon.snp.makeConstraints{
            $0.top.equalTo(locationLabel.snp.bottom).offset(16.0)
            $0.centerX.equalToSuperview()

            //$0.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
        }
        temperatureLabel.snp.makeConstraints{
            $0.leading.equalTo(locationLabel.snp.trailing).offset(27.0)
            $0.top.equalToSuperview().inset(40.0)
        }
        recommendLabel.snp.makeConstraints{
            //$0.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(mainIcon.snp.bottom).offset(16.0)
            //$0.bottom.equalToSuperview().inset(24.0)
        }
        
    }
}

