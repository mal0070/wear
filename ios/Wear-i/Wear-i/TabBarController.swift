//
//  TabBarController.swift
//  Wear-i
//
//  Created by 이민아 on 2022/11/13.
//

import UIKit
import Foundation

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let mainView = UINavigationController(rootViewController: MainViewController(bgColor: UIColor.white))
        let communityView = UINavigationController(rootViewController: CommunityViewController(bgColor: UIColor.white))
        let voteView = UINavigationController(rootViewController: VoteViewController(bgColor: UIColor.white))
        let scrapView = UINavigationController(rootViewController: ScrapViewController(bgColor: UIColor.white))
        let myPageView = UINavigationController(rootViewController: MyPageViewController(bgColor: UIColor.white))
        
        //탭바 아이템 설정
        mainView.tabBarItem = UITabBarItem(title: "메인", image: nil, selectedImage: nil)
        communityView.tabBarItem = UITabBarItem(title: "커뮤니티", image: nil, selectedImage: nil)
        voteView.tabBarItem = UITabBarItem(title: "투표", image: nil, selectedImage: nil)
        scrapView.tabBarItem = UITabBarItem(title: "스크랩", image: nil, selectedImage: nil)
        myPageView.tabBarItem = UITabBarItem(title: "마이페이지", image: nil, selectedImage: nil)
        
        ///탭바컨트롤러에 뷰 컨트롤러를 array형식으로 넣어줌
        self.viewControllers = [mainView, communityView, voteView, scrapView, myPageView]

    }
    



}

