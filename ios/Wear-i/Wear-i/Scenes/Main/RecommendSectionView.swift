//
//  RecommendSectionView.swift
//  Wear-i
//
//  Created by 이민아 on 2023/01/23.
//

import UIKit
import SnapKit
import Alamofire
import Kingfisher

final class RecommendSectionView: UIView {
    
    private var fashion: Fashion?
    
    
    private var previousIndex = 0
    private var minItemSpacing: CGFloat = 16.0
    
    private lazy var collectionView: UICollectionView = {

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        //collectionView.isPagingEnabled = true -> 쓰면 안됨 페이지 넓이 조절 위해 : scrollViewWillEndDragging 사용
        collectionView.backgroundColor = UIColor(named: "w_background")
        collectionView.showsHorizontalScrollIndicator = false //스크롤바 숨김
        
        collectionView.register(RecommendCollectionViewCell.self, forCellWithReuseIdentifier: "RecommendCollectionViewCell")
        collectionView.decelerationRate = .fast
        
    
        /*collectionView.contentInsetAdjustmentBehavior = .never //safe area 때문에 가려지는 것 방지
        let cellWidth : CGFloat = frame.width*0.8
        let insetX = (self.bounds.width - cellWidth) / 2.0
        collectionView.contentInset = UIEdgeInsets(top: 0.0, left: insetX, bottom: 0.0, right: insetX)
        */
        
        return collectionView
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    /*init(fashion: Fashion){
        self.fashion = fashion
        super.init(frame: .zero)*/
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview().inset(16.0)
            $0.height.equalTo(snp.width)
            $0.bottom.equalToSuperview()
        }
        requestRecommendFashion()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

//MARK: Networking
extension RecommendSectionView {
    private func requestRecommendFashion(){
        let urlString = "http://3.35.150.76:8080/v1/community?count=10"
        AF.request(urlString).responseDecodable(of: Fashion.self) { [weak self] response in
                guard case .success(let data) = response.result else {return}
            //print(data.payload) //이게 url
            self?.fashion = data
            self?.collectionView.reloadData()
            }
        .resume()
    }
}


extension RecommendSectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendCollectionViewCell", for: indexPath) as? RecommendCollectionViewCell
        
        let url = fashion?.payload[indexPath.row] ?? "url"
        guard let imgURL = URL(string: url) else {
            return cell ?? UICollectionViewCell()
        } //옵셔널 바인딩
        cell?.clothImageView.kf.setImage(with: imgURL)
        cell?.setup()
        return cell ?? UICollectionViewCell()
    }
}


extension RecommendSectionView: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return minItemSpacing
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: frame.width*0.8 , height: frame.width)
    }
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //postVc
    
    }
    

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let cellWidth : CGFloat = frame.width*0.8
        let insetX = (self.bounds.width - cellWidth) / 2.0
        return UIEdgeInsets(top: 0.0, left: insetX, bottom: 0.0, right: insetX)
    }
    
    //MARK: paging Effect
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let cellWidth: CGFloat = frame.width*0.8
        let cellWidthIncludeSpacing = cellWidth + minItemSpacing //cell 한칸
        
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludeSpacing
        let roundedIndex: CGFloat = round(index) //round: 소수점 반올림
        
        offset = CGPoint(x: roundedIndex * cellWidthIncludeSpacing - scrollView.contentInset.left, y: scrollView.contentInset.top)
        targetContentOffset.pointee = offset //가운데 정렬 페이징 -> 왜 안되지
    }
    
    //MARK: Carousel Effect: Cell 포커스되면 커지는 효과
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let cellWidth = frame.width*0.8
        let cellWidthIncludeSpacing = cellWidth + minItemSpacing
        let offsetX = collectionView.contentOffset.x
        let index = (offsetX + collectionView.contentInset.left) / cellWidthIncludeSpacing
        let roundedIndex = round(index)
        let indexPath = IndexPath(item: Int(roundedIndex), section: 0)
        if let cell = collectionView.cellForItem(at: indexPath) {
            animateZoomforCell(zoomCell: cell as! RecommendCollectionViewCell)
        }
        
        if Int(roundedIndex) != previousIndex {
            let preIndexPath = IndexPath(item: previousIndex, section: 0)
            if let preCell = collectionView.cellForItem(at: preIndexPath) {
                animateZoomforCellremove(zoomCell: preCell as! RecommendCollectionViewCell)
            }
            previousIndex = indexPath.item
        }
    }
    
    
    func animateZoomforCell(zoomCell: RecommendCollectionViewCell) {
        RecommendSectionView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {zoomCell.transform = .identity}, completion: nil)
    }
    
    func animateZoomforCellremove(zoomCell: RecommendCollectionViewCell) {
        RecommendSectionView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {zoomCell.transform = CGAffineTransform(scaleX: 0.5, y: 0.5) })
    }
}






