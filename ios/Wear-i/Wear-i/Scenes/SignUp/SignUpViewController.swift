//
//  SignUpViewController.swift
//  Wear-i
//
//  Created by 이민아 on 2022/11/22.
//

import UIKit
import SnapKit

class SignUpViewController: UIViewController {
    // MARK: - Init: Lazy 사용위해(메모리 절약)
    convenience init(bgColor: UIColor) {
        self.init()
        self.view.backgroundColor = bgColor
    }
    
    //MARK: Properties
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "w_gray")
        return view
    }()
    
    private lazy var completeLabel: UILabel = {
        let label = UILabel()
        label.text = "회원가입이\n완료되었어요!"
        label.numberOfLines = 2
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "Pretendard-Bold", size: 24)
        return label
    }()
    
    private var mainIcon = UIImageView(image: UIImage(named: "흐림"))
    
    private lazy var goLabel: UILabel = {
        let label = UILabel()
        label.text = "취향저격 코디 추천을 위해\n정보를 입력하러 갈까요?"
        label.numberOfLines = 2
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "Pretendard-Bold", size: 20)
        return label
    }()
    
    private lazy var infoButton: UIButton = {
        let button = MyButton(title: "정보입력", bgColor: UIColor(named: "w_orange") ?? .orange, titleColor: .white)
        button.addTarget(self, action: #selector(pushInfoView), for: .touchUpInside)
        return button
    }()
    
    private lazy var nextTimebutton: UIButton = {
        let button = MyButton(title: "다음에 할게요", bgColor: UIColor(named: "w_gray") ?? .orange, titleColor: .white)
        button.addTarget(self, action: #selector(goToTab), for: .touchUpInside)
        return button
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "w_background")
        setupLayout()
        //back button 숨기기
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = true

    }
    
    //MARK: Layout
    func setupLayout(){
        let inset : CGFloat = 20.0
        
        let stackView = UIStackView(arrangedSubviews: [infoButton, nextTimebutton])
        stackView.axis = .vertical //세로
        stackView.spacing = 15.0
        [backgroundView, completeLabel, mainIcon,goLabel, stackView].forEach{view.addSubview($0)}
        
        backgroundView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(inset)
            $0.leading.equalToSuperview().inset(inset)
            $0.trailing.equalToSuperview().inset(inset)
            $0.bottom.equalTo(goLabel.snp.bottom).offset(75)
        }
        completeLabel.snp.makeConstraints{
            $0.top.equalTo(backgroundView.snp.top).offset(30)
            $0.centerX.equalTo(backgroundView.snp.centerX)
        }
        mainIcon.snp.makeConstraints{
            $0.top.equalTo(completeLabel.snp.bottom).offset(145)
            $0.centerX.equalTo(backgroundView.snp.centerX)
            $0.width.equalTo(120)
            $0.height.equalTo(90)
        }
        goLabel.snp.makeConstraints{
            $0.top.equalTo(mainIcon.snp.bottom).offset(inset)
            $0.centerX.equalTo(backgroundView.snp.centerX)
        }
        
        stackView.snp.makeConstraints{
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(95.0)
            $0.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
        }

        
    }
    
    //MARK: Animation
    @objc func pushInfoView() {
       let vc = InfoViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func goToTab(){
        //현재 화면을 닫고 tab열기
        //여기서 여러 페이지를 넘긴 후 새로운 페이지 시작되므로 rootViewController.dismiss
        self.view.window?.rootViewController?.dismiss(animated: false, completion: {
            let tab = TabBarController()
            tab.modalTransitionStyle = .crossDissolve
            tab.modalPresentationStyle = .fullScreen
            self.present(tab, animated: true)
        })
    }
}

