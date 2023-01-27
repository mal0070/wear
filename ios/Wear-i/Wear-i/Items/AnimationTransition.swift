//
//  AnimationTransition.swift
//  Wear-i
//
//  Created by 이민아 on 2023/01/25.
//

import UIKit

class AnimationTransition: UIPercentDrivenInteractiveTransition, UIViewControllerAnimatedTransitioning {
    var originPoint: CGPoint?
    var originFrame: CGRect?
    
    func setPoint(point: CGPoint?) {
        self.originPoint = point
    }
    
    func setFrame(frame: CGRect?) {
        self.originFrame = frame
    }
    
    //애니메이션 동작 시간
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    //애니메이션 효과 정의
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView //뷰를 담을 전체 틀
        //다음 보여질 뷰 참조
        guard let toView = transitionContext.view(forKey: .to) else { //to: 앞으로 보여질 뷰
            return
        }
        //보여질 뷰의 위치잡기 (cell의 frame)
        toView.frame = originFrame!
        
        //CGAffineTransform을 이용한 효과
        toView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        
        containerView.addSubview(toView)
        containerView.bringSubviewToFront(toView) //계층 위로 올리기
        
        toView.layer.masksToBounds = true
        toView.alpha = 0
        
        //애니메이션 적용
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            //원래 자리로 되돌리면서 애니메이션 이동 효과
            toView.transform = .identity
            toView.alpha = 1
        }) { _ in
            toView.translatesAutoresizingMaskIntoConstraints = false
            toView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
            toView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
            toView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
            toView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
            UIView.animate(withDuration: 1) {
                containerView.layoutIfNeeded()
            } //애니메이션 후 화면 꽉차게
        }
        
        transitionContext.completeTransition(true)
    }
}

