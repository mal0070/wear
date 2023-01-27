//
//  InitViewController.swift
//  Wear-i
//
//  Created by 이민아 on 2023/01/11.
//

import UIKit
import SnapKit

class InitViewController: UIViewController {
    // MARK: - Init: Lazy 사용위해(메모리 절약)
    convenience init(bgColor: UIColor) {
        self.init()
        self.view.backgroundColor = bgColor
    }
    
    //MARK: Properties
    private lazy var appNameLabel: UILabel = {
        let label = UILabel()
        label.text = "WEATHER"
        label.font = UIFont(name: "Pretendard-ExtraBold", size: 35)
        label.textColor = .white
        return label
    }()
    
    private lazy var loginButton: UIButton = {
        let button = MyButton(title: "로그인", bgColor: UIColor(named: "w_orange") ?? .orange, titleColor: .white)
        button.addTarget(self, action: #selector(pushLoginView), for: .touchUpInside)
        return button
    }()
    
    private lazy var signUpbutton: UIButton = {
        let button = MyButton(title: "회원가입", bgColor: UIColor(named: "w_gray") ?? .orange, titleColor: .white)
        button.addTarget(self, action: #selector(pushSignUpView), for: .touchUpInside)
        return button
    }()
    
    private lazy var findLabel: UILabel = {
        let label = UILabel()
        label.text = "아이디/비밀번호 찾기"
        label.font = UIFont(name: "Pretendard-Medium", size: 16.0)
        label.textColor = .lightGray
        return label
    }()
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "w_background")
        setupLayout()
        
        let find = UITapGestureRecognizer(target: self, action: #selector(self.pushFindView))
        findLabel.isUserInteractionEnabled = true
        findLabel.addGestureRecognizer(find)

    }
    
    //MARK: Layout
    func setupLayout(){
        let inset: CGFloat = 20.0
        
        let stackView = UIStackView(arrangedSubviews: [loginButton, signUpbutton])
        stackView.axis = .vertical //세로
        stackView.spacing = 15.0
        
        [appNameLabel,stackView, findLabel].forEach{view.addSubview($0)}
        
        appNameLabel.snp.makeConstraints{
            $0.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)//중앙정렬
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(190.0)
        }
        
        stackView.snp.makeConstraints{
            $0.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(90.0)
        }
        findLabel.snp.makeConstraints{
            $0.top.equalTo(stackView.snp.bottom).offset(inset)
            $0.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
        }
    }
    
    //MARK: Animation
    @objc func pushLoginView(){
        let vc1 = LoginViewController()
        self.navigationController?.pushViewController(vc1, animated: true)
    }
                         
    @objc func pushSignUpView(){
        let vc2 = IdViewController()
        self.navigationController?.pushViewController(vc2, animated: true)
    }
    
    @objc func pushFindView(){
            //아이디 비밀번호 찾기
        }
   

}
