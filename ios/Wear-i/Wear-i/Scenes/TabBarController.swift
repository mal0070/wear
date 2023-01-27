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
        
        let mainView = UINavigationController(rootViewController: MainViewController(bgColor: UIColor(named: "w_background") ?? UIColor.black))
        let communityView = UINavigationController(rootViewController: CommunityViewController(bgColor: UIColor(named: "w_background") ?? UIColor.black))
        let voteView = UINavigationController(rootViewController: VoteViewController(bgColor: UIColor(named: "w_background") ?? UIColor.black))
        let scrapView = UINavigationController(rootViewController: ScrapViewController(bgColor: UIColor(named: "w_background") ?? UIColor.black))
        let myPageView = UINavigationController(rootViewController: MyPageViewController(bgColor: UIColor(named: "w_background") ?? UIColor.black))
        

        
        //탭바 아이템 설정
        self.tabBar.tintColor = .white
        self.tabBar.unselectedItemTintColor = .lightGray
        mainView.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "홈"), selectedImage: nil)
        communityView.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "커뮤니티"), selectedImage: nil)
        voteView.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "픽(투표)"), selectedImage: nil)
        scrapView.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "스크랩북"), selectedImage: nil)
        myPageView.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "마이페이지"), selectedImage: nil)
     
        
        ///탭바컨트롤러에 뷰 컨트롤러를 array형식으로 넣어줌
        self.viewControllers = [mainView, communityView, voteView, scrapView, myPageView]

    }
    



}

