//
//  PassWordViewController.swift
//  Wear-i
//
//  Created by 이민아 on 2023/01/11.
//

import UIKit
import SnapKit

class PassWordViewController: UIViewController {
    // MARK: - Init: Lazy 사용위해(메모리 절약)
    convenience init(bgColor: UIColor) {
        self.init()
        self.view.backgroundColor = bgColor
    }
    
    //MARK: Properties
    private lazy var pwLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호"
        label.font = UIFont(name: "Pretendard-Bold", size: 28)
        label.textColor = .white
        return label
    }()
    
    private lazy var pwTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "영문, 숫자 조합 8자리 이상", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
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
    
    private lazy var pwCheckLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호 확인"
        label.font = UIFont(name: "Pretendard-Bold", size: 28)
        label.textColor = .white
        return label
    }()
    
    private lazy var pwCheckTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 17)
        textField.isSecureTextEntry = true //비밀번호는 보이지 않게
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
    
    private lazy var nextButton: UIButton = {
        let button = MyButton(title: "다음", bgColor: UIColor(named: "w_gray")!, titleColor: .lightGray)
        button.addTarget(self, action: #selector(pushNickNameView), for: .touchUpInside)
        
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
        [pwLabel, pwTextField, underLineView1, pwCheckLabel, pwCheckTextField, underLineView2, wrongAlertLabel, nextButton].forEach{view.addSubview($0)}
        
        let inset: CGFloat = 20.0
        
        pwLabel.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(inset)
            $0.leading.equalToSuperview().inset(inset)
        }
        
        pwTextField.snp.makeConstraints{
            $0.top.equalTo(pwLabel.snp.bottom).offset(inset)
            $0.leading.equalTo(pwLabel.snp.leading)
            $0.trailing.equalToSuperview().inset(inset)
        }
        underLineView1.snp.makeConstraints{
            $0.top.equalTo(pwTextField.snp.bottom).offset(5.0)
            $0.leading.equalTo(pwLabel.snp.leading)
            $0.trailing.equalTo(pwTextField.snp.trailing)
            $0.height.equalTo(1.0)
        }
        pwCheckLabel.snp.makeConstraints{
            $0.top.equalTo(underLineView1.snp.bottom).offset(25.0)
            $0.leading.equalTo(pwLabel.snp.leading)
        }
        pwCheckTextField.snp.makeConstraints{
            $0.top.equalTo(pwCheckLabel.snp.bottom).offset(inset)
            $0.leading.equalTo(pwLabel.snp.leading)
            $0.trailing.equalToSuperview().inset(inset)
        }
        underLineView2.snp.makeConstraints{
            $0.top.equalTo(pwCheckTextField.snp.bottom).offset(5.0)
            $0.leading.equalTo(pwLabel.snp.leading)
            $0.trailing.equalTo(pwTextField.snp.trailing)
            $0.height.equalTo(1.0)
        }
        wrongAlertLabel.snp.makeConstraints{
            $0.top.equalTo(underLineView2.snp.bottom).offset(5.0)
            $0.leading.equalTo(pwLabel.snp.leading)
        }
        nextButton.snp.makeConstraints{
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(95.0)
            $0.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
        }
    }
    
    //MARK: Animation
    @objc func pushNickNameView(){
        let vc = NickNameViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if pwTextField.text?.isEmpty == false && pwCheckTextField.text?.isEmpty == false {
            nextButton.isUserInteractionEnabled = true
            nextButton.backgroundColor = UIColor(named: "w_orange")
            nextButton.titleLabel?.textColor = .white
            underLineView2.backgroundColor = UIColor(named: "w_orange")
        } //문제점: enter를 눌러야 활성화됨
        else if pwTextField.text?.isEmpty == false {
            underLineView1.backgroundColor = UIColor(named: "w_orange")
        }
        else if pwCheckTextField.text?.isEmpty == false {
            underLineView2.backgroundColor = UIColor(named: "w_orange")
        }
    }
}

extension PassWordViewController: UITextFieldDelegate {
    //return -> 키보드 내려가도록
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
}
