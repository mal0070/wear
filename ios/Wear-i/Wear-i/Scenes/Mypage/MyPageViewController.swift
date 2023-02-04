//
//  MyPageViewController.swift
//  Wear-i
//
//  Created by 이민아 on 2022/11/13.
//


import UIKit

class MyPageViewController: UIViewController {
    // MARK: - Init: Lazy 사용위해(메모리 절약)
    convenience init(bgColor: UIColor) {
        self.init()
        self.view.backgroundColor = bgColor
    }
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 0.0
        
        let profileSectionView = ProfileSectionView(frame: .zero)
        let myContentSectionView = MyContentSectionView(frame: .zero)
       
        
        [profileSectionView, myContentSectionView].forEach{stackView.addArrangedSubview($0)}
         
        profileSectionView.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(100)
        }
        myContentSectionView.snp.makeConstraints{
            $0.top.equalTo(profileSectionView.snp.bottom).offset(30.0)
            $0.leading.equalTo(profileSectionView)
            $0.trailing.equalTo(profileSectionView)
            $0.height.equalTo(1000) //collectionViewCell 만들면 삭제할거임
        }
        return stackView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupLayout()
    }
    
    
    
    //MARK: Animation
    @objc func addPost(){
            
        }
    @objc func filterToast(){
        
    }

}

private extension MyPageViewController {
    func setupNavigationBar(){
        let title = UILabel()
        title.text = "USERNAME"
        title.textColor = .white
        title.font = UIFont(name: "Pretendard-ExtraBold", size: 30)
        title.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: title)
        
        let addButton = UIBarButtonItem(title: nil, image: UIImage(systemName: "plus.app"), target: self, action: #selector(addPost))
        let filterButton = UIBarButtonItem(title: nil, image: UIImage(systemName: "slider.horizontal.3"), target: self, action: #selector(filterToast))
        navigationItem.rightBarButtonItems = [addButton,filterButton]
        addButton.tintColor = .white
        filterButton.tintColor = .white
        
    }
    
    //MARK: Layout
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




