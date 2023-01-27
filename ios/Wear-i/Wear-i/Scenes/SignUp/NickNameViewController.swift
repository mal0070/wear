//
//  NickNameViewController.swift
//  Wear-i
//
//  Created by 이민아 on 2023/01/11.
//

import UIKit
class NickNameViewController: UIViewController {
    // MARK: - Init: Lazy 사용위해(메모리 절약)
    convenience init(bgColor: UIColor) {
        self.init()
        self.view.backgroundColor = bgColor
    }
    
    //MARK: Properties
    private lazy var nicknameLabel: UILabel = {
        let label = UILabel()
        label.text = "사용하실 \n닉네임을 입력해 주세요."
        label.numberOfLines = 2 //두 줄
        label.font = UIFont(name: "Pretendard-Bold", size: 28)
        label.textColor = .white
        return label
    }()
    
    private lazy var nicknameTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "2자리 이상", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.font = .systemFont(ofSize:17.0)
        textField.textColor = .white
        textField.delegate = self
        return textField
    }()
    
    private lazy var underLineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = .lightGray
        return lineView
    }()
    
    private lazy var wrongAlertLabel: UILabel = {
        let label = UILabel()
        label.text = "*사용 중인 닉네임입니다."
        label.font = UIFont(name: "Pretendard-Light", size: 16.0)
        label.textColor = UIColor(named: "w_orange")
        return label
    }() //hidden
    
    private lazy var nextButton: UIButton = {
        let button = MyButton(title: "다음", bgColor: UIColor(named: "w_gray")!, titleColor: .lightGray)
        button.addTarget(self, action: #selector(pushSignUpView), for: .touchUpInside)
        
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
        [nicknameLabel, nicknameTextField, underLineView, wrongAlertLabel,nextButton] .forEach{view.addSubview($0)}
        
        let inset : CGFloat = 20.0
        
        nicknameLabel.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(inset)
            $0.leading.equalToSuperview().inset(inset)
        }
        
        nicknameTextField.snp.makeConstraints{
            $0.top.equalTo(nicknameLabel.snp.bottom).offset(inset)
            $0.leading.equalTo(nicknameLabel.snp.leading)
            $0.trailing.equalToSuperview().inset(inset)
        }
        underLineView.snp.makeConstraints{
            $0.top.equalTo(nicknameTextField.snp.bottom).offset(5.0)
            $0.leading.equalTo(nicknameLabel.snp.leading)
            $0.trailing.equalTo(nicknameTextField.snp.trailing)
            $0.height.equalTo(1.0)
        }
        wrongAlertLabel.snp.makeConstraints{
            $0.top.equalTo(underLineView.snp.bottom).offset(5.0)
            $0.leading.equalTo(nicknameLabel.snp.leading)
        }
        nextButton.snp.makeConstraints{
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(95.0)
            $0.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
        }
    }
    

    
    //MARK: Animation
    @objc func pushSignUpView(){
        let vc = SignUpViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if nicknameTextField.text?.isEmpty == false {
            underLineView.backgroundColor = UIColor(named: "w_orange")
            nextButton.backgroundColor = UIColor(named: "w_orange")
            nextButton.isUserInteractionEnabled = true
            nextButton.titleLabel?.textColor = .white
        }
    }
    
    
}

extension NickNameViewController: UITextFieldDelegate {
    //return -> 키보드 내려가도록
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
}
