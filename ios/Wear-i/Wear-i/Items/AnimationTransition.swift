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
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    // animation될 뷰지정
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        // 다음 보여질뷰 참조
        guard let toView = transitionContext.view(forKey: .to) else {
            return
        }
        // 보여질뷰의 위치잡기 (Cell의 frame)
        toView.frame = originFrame!

        // MARK: CGAffineTransform을 이용한 효과
        toView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)

        containerView.addSubview(toView)
        // hierarchy on top
        containerView.bringSubviewToFront(toView)
        
        toView.layer.masksToBounds = true
        toView.layer.cornerRadius = 20
        toView.alpha = 0
        // MARK: 애니메이션 적용
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {


        // MARK: 원래자리로 되돌리면서 애니메이션 이동효과
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
            }
        }
        
        transitionContext.completeTransition(true)
    }
}
