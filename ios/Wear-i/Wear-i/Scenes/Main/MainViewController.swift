//
//  ViewController.swift
//  Wear-i
//
//  Created by 이민아 on 2022/11/12.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {
    // MARK: - Init: Lazy 사용위해(메모리 절약)
    convenience init(bgColor: UIColor) {
        self.init()
        self.view.backgroundColor = bgColor
    }
    //recommedCell이 collectionView임. 그러면 이거만 collectionView 하면 됨 그냥
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 0.0
        
        let weatherSectionView = WeatherSectionView(frame: .zero)
        let recommendSectionView = RecommendSectionView(frame: .zero)
        
        [weatherSectionView, recommendSectionView].forEach{stackView.addArrangedSubview($0)}

        
        /*let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapWeather(sender: )))
        weatherSectionView.addGestureRecognizer(tapGesture)*/
        return stackView
    }()

    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupLayout()
        
    }
}

//MARK: Custom NavigationBar, Layout
private extension MainViewController{
    func setupNavigationBar(){
        let title = UILabel()
        title.text = "WEATHER"
        title.textColor = .white
        title.font = UIFont(name: "Pretendard-ExtraBold", size: 30)
        title.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: title)
        let noticeButton = UIBarButtonItem(title: "", image: UIImage(systemName: "bell"), target: self, action: #selector(showNotice))
        navigationItem.rightBarButtonItem = noticeButton
        noticeButton.tintColor = .white
        //MARK: Property Layout
    }
    func setupLayout() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints{
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
}

//MARK: Animation
private extension MainViewController {
    @objc func showNotice(){
        //return 0
    }
    
    @objc func tapWeather(sender: UITapGestureRecognizer) {
        let vc = WeatherViewController()
        present(vc, animated: true)
    }
}

/*
extension MainViewController: UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {
    //present 실행될 때 애니메이션
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        //
    }
}

//collectionViewCell로 고치기
    */

