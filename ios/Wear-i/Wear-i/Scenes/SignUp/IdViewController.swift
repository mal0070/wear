//
//  IdViewController.swift
//  Wear-i
//
//  Created by 이민아 on 2023/01/11.
//

import UIKit
import SnapKit

class IdViewController: UIViewController {
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
        //textField.borderStyle = .roundedRect //경계선 모양
        textField.textColor = .white
        textField.delegate = self
        return textField
    }()
    
    private lazy var underLineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = .lightGray //비활성화 활성화
        
        return lineView
    }()
    
    private lazy var wrongAlertLabel: UILabel = {
        let label = UILabel()
        label.text = "*올바르지 않은 이메일 형식입니다."
        label.font = UIFont(name: "Pretendard-Light", size: 16.0)
        label.textColor = UIColor(named: "w_orange")
        return label
    }() //hidden
    
    private lazy var nextButton: UIButton = {
        let button = MyButton(title: "다음", bgColor: UIColor(named: "w_gray")!, titleColor: .lightGray)
        button.addTarget(self, action: #selector(pushPwView), for: .touchUpInside)
        
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
        [idLabel, emailTextField, underLineView, wrongAlertLabel,nextButton] .forEach{view.addSubview($0)}
        
        let inset : CGFloat = 20.0
        
        idLabel.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(inset)
            $0.leading.equalToSuperview().inset(inset)
        }
        
        emailTextField.snp.makeConstraints{
            $0.top.equalTo(idLabel.snp.bottom).offset(inset)
            $0.leading.equalTo(idLabel.snp.leading)
            $0.trailing.equalToSuperview().inset(inset)
        }
        underLineView.snp.makeConstraints{
            $0.top.equalTo(emailTextField.snp.bottom).offset(5.0)
            $0.leading.equalTo(idLabel.snp.leading)
            $0.trailing.equalTo(emailTextField.snp.trailing)
            $0.height.equalTo(1.0)
        }
        wrongAlertLabel.snp.makeConstraints{
            $0.top.equalTo(underLineView.snp.bottom).offset(5.0)
            $0.leading.equalTo(idLabel.snp.leading)
        }
        nextButton.snp.makeConstraints{
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(95.0)
            $0.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
        }
    }
    

    
    //MARK: Animation
    @objc func pushPwView(){
        let vc = PassWordViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if emailTextField.text?.isEmpty == false {
            underLineView.backgroundColor = UIColor(named: "w_orange")
            nextButton.backgroundColor = UIColor(named: "w_orange")
            nextButton.isUserInteractionEnabled = true
            nextButton.titleLabel?.textColor = .white
        }
    }
    
}


extension IdViewController: UITextFieldDelegate {
    //return -> 키보드 내려가도록
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
}
