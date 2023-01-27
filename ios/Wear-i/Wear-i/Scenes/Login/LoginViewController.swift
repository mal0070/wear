//
//  LoginViewController.swift
//  Wear-i
//
//  Created by 이민아 on 2022/11/13.
//

import UIKit
import SnapKit
import Alamofire

class LoginViewController: UIViewController {
    // MARK: - Init: Lazy 사용위해(메모리 절약)
    convenience init(bgColor: UIColor) {
        self.init()
        self.view.backgroundColor = bgColor
    }
    
    //MARK: Properties
    private lazy var idLabel: UILabel = {
        let label = UILabel()
        label.text = "아이디"
        label.font = UIFont(name: "Pretendard-Bold", size: 28)
        label.textColor = .white
        return label
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "이메일 주소", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.font = .systemFont(ofSize:17.0)
        textField.textColor = .white
        textField.delegate = self
        return textField
    }()
    
    private lazy var underLineView1: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = .lightGray
        
        return lineView
    }()
    
    private lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호"
        label.font = UIFont(name: "Pretendard-Bold", size: 28)
        label.textColor = .white
        return label
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 17)
        //textField.borderStyle = .roundedRect //경계선 모양
        textField.isSecureTextEntry = true //비밀번호는 보이지 않게
        textField.attributedPlaceholder = NSAttributedString(string: "영문, 숫자 조합 8자리 이상", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]) //placeholder 색상 바꾸기
        textField.textColor = .white
        textField.delegate = self
        return textField
    }()
    
    private lazy var underLineView2: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = .lightGray
        
        return lineView
    }()
    
    private lazy var wrongAlertLabel: UILabel = {
        let label = UILabel()
        label.text = "*올바르지 않은 비밀번호 형식입니다."
        label.font = UIFont(name: "Pretendard-Light", size: 16.0)
        label.textColor = UIColor(named: "w_orange")
        return label
    }() //hidden
    
    private lazy var loginButton: UIButton = {
        let button = MyButton(title: "로그인", bgColor: UIColor(named: "w_gray")!, titleColor: .lightGray)
        button.addTarget(self, action: #selector(goToTab), for: .touchUpInside)
        
        button.isUserInteractionEnabled = false
        return button
    }()
   
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "w_background")
        setupLayout()
        
        wrongAlertLabel.isHidden = true
        
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.topItem?.title = ""
    }

    //MARK: Layout
    func setupLayout(){
        [idLabel, emailTextField, underLineView1, passwordLabel, passwordTextField, underLineView2, wrongAlertLabel,loginButton] .forEach{view.addSubview($0)}
        
        let inset: CGFloat = 20.0
        
        idLabel.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(inset)
            $0.leading.equalToSuperview().inset(inset)
        }
        
        emailTextField.snp.makeConstraints{
            $0.top.equalTo(idLabel.snp.bottom).offset(inset)
            $0.leading.equalTo(idLabel.snp.leading)
            $0.trailing.equalToSuperview().inset(inset)
        }
        underLineView1.snp.makeConstraints{
            $0.top.equalTo(emailTextField.snp.bottom).offset(5.0)
            $0.leading.equalTo(idLabel.snp.leading)
            $0.trailing.equalTo(emailTextField.snp.trailing)
            $0.height.equalTo(1.0)
        }
        passwordLabel.snp.makeConstraints{
            $0.top.equalTo(underLineView1.snp.bottom).offset(25.0)
            $0.leading.equalTo(idLabel.snp.leading)
        }
        passwordTextField.snp.makeConstraints{
            $0.top.equalTo(passwordLabel.snp.bottom).offset(inset)
            $0.leading.equalTo(idLabel.snp.leading)
            $0.trailing.equalToSuperview().inset(inset)
        }
        underLineView2.snp.makeConstraints{
            $0.top.equalTo(passwordTextField.snp.bottom).offset(5.0)
            $0.leading.equalTo(idLabel.snp.leading)
            $0.trailing.equalTo(emailTextField.snp.trailing)
            $0.height.equalTo(1.0)
        }
        wrongAlertLabel.snp.makeConstraints{
            $0.top.equalTo(underLineView2.snp.bottom).offset(5.0)
            $0.leading.equalTo(idLabel.snp.leading)
        }
        
        loginButton.snp.makeConstraints{
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(95.0)
            $0.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
        }
        
    }
    
    
    //MARK: Animation
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
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if emailTextField.text?.isEmpty == false && passwordTextField.text?.isEmpty == false {
            loginButton.isUserInteractionEnabled = true
            loginButton.backgroundColor = UIColor(named: "w_orange")
            loginButton.titleLabel?.textColor = .white
            underLineView2.backgroundColor = UIColor(named: "w_orange")
        } //문제점: enter를 눌러야 활성화됨
        else if emailTextField.text?.isEmpty == false {
            underLineView1.backgroundColor = UIColor(named: "w_orange")
        }
        else if passwordTextField.text?.isEmpty == false {
            underLineView2.backgroundColor = UIColor(named: "w_orange")
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

//MARK: Login Server Connection
extension LoginViewController {
    func Login() {}
}


