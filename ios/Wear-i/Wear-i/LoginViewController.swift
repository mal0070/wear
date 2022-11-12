//
//  LoginViewController.swift
//  Wear-i
//
//  Created by 이민아 on 2022/11/13.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    // MARK: - Init: Lazy 사용위해(메모리 절약)
    convenience init(bgColor: UIColor) {
        self.init()
        self.view.backgroundColor = bgColor
    }
    //MARK: Properties
    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "환영합니다"
        label.font = .systemFont(ofSize: 25, weight: .bold)
        return label
    }()
    
    private lazy var idTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "아이디를 입력하세요."
        textField.font = .systemFont(ofSize: 17)
        textField.borderStyle = .roundedRect //경계선 모양
        
        textField.delegate = self
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호를 입력하세요."
        textField.font = .systemFont(ofSize: 17)
        textField.borderStyle = .roundedRect //경계선 모양
        textField.isSecureTextEntry = true //비밀번호는 보이지 않게
        
        textField.delegate = self
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type:.custom)
        button.setTitle("로그인", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 30.0, weight: .medium)
        button.backgroundColor = .black
        button.layer.cornerRadius = 15.0
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(goToTab), for: .touchUpInside)
        
        return button
    }()
   
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        /* let label = UILabel(frame: CGRect(x:100, y:200, width: 200, height: 100))
        label.text = "Login"
        label.sizeToFit() //자동으로 레이블 크기 조정 (글자 생략 없이 표현 가능)
        label.center.x = self.view.frame.width/2
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapFunction))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(tap)

        self.view.addSubview(label)
         */
        
        super.viewDidLoad()
        setupLayout()
        
    }

    
    @objc func goToTab(){
        let tab = TabBarController()
        tab.modalPresentationStyle = .fullScreen //화면이 보여지는 방식
        tab.modalTransitionStyle = .crossDissolve //화면 전환 애니메이션
        
        //현재 화면을 닫고 tab열기
        present(tab, animated: true)
        
        if presentedViewController == tab { //호출된 화면이 탭이면
            presentingViewController?.dismiss(animated: true) //호출한 화면닫기
        }
    }
    
    //MARK: Layout
    func setupLayout(){
        [welcomeLabel, idTextField, passwordTextField, loginButton].forEach{view.addSubview($0)}
        
        let inset: CGFloat = 16.0
        
        welcomeLabel.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(30.0)
            $0.leading.equalToSuperview().inset(inset)
        }
        idTextField.snp.makeConstraints{
            $0.top.equalTo(welcomeLabel.snp.bottom).offset(inset)
            $0.leading.equalTo(welcomeLabel.snp.leading)
            $0.trailing.equalToSuperview().inset(inset)
        }
        passwordTextField.snp.makeConstraints{
            $0.top.equalTo(idTextField.snp.bottom).offset(6.0)
            $0.leading.equalTo(welcomeLabel.snp.leading)
            $0.trailing.equalToSuperview().inset(inset)
        }
        loginButton.snp.makeConstraints{
            $0.top.equalTo(passwordTextField.snp.bottom).offset(25.0)
            $0.leading.equalTo(welcomeLabel.snp.leading)
            $0.trailing.equalToSuperview().inset(inset)
        }
        
        
    }

  

}

extension LoginViewController: UITextFieldDelegate {
    //return -> 키보드 내려가도록
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
}


