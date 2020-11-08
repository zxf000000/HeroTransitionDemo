//
//  Transition.swift
//  HeroDemo
//
//  Created by mr.zhou on 2020/11/8.
//

import Foundation
import UIKit

class Transition: NSObject, UIViewControllerAnimatedTransitioning {

    
    private var isPresent: Bool = true
    
    init(_ isPresent: Bool) {
        super.init()
        self.isPresent = isPresent
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }

    // This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: .from)
        let toVC = transitionContext.viewController(forKey: .to)
        let container = transitionContext.containerView
        if isPresent {
            if let fromView = fromVC?.view,
               let toView = toVC?.view {
                container.addSubview(toView)
                toView.frame = CGRect(x: 0, y: 88, width: container.bounds.size.width, height: container.bounds.size.height)
                toView.alpha = 0
                container.layoutIfNeeded()
                container.updateConstraints()
                container.setNeedsLayout()
                toView.layoutIfNeeded()
                toView.setNeedsLayout()
                toView.updateConstraints()
                
                var snapshots = [TransitionItem]()
                if let fromContainer = fromVC?.transitionContainer,
                   let toContainer = toVC?.transitionContainer {
                    for key in fromContainer.keys {
                        if let fromV = fromContainer.dic[key], let toV = toContainer.dic[key] {
                            print(key)
                            let img = fromV.screenshot
                            let imageView = UIImageView(image: img)
                            fromV.isHidden = true
                            // 转换 frame
                            let fromFrame = fromV.superview?.convert(fromV.frame, to: container)
                            imageView.frame = fromFrame!
                            let toFrame = toV.superview?.convert(toV.frame, to: container)
                            container.insertSubview(imageView, belowSubview: toV)
//                            container.addSubview(imageView)
                                                        
                            toV.isHidden = true
                            let transitionItem = TransitionItem(fromView: fromV, toView: toV, snapShot: imageView, toFrame: toFrame)
                            snapshots.append(transitionItem)
                        }
                        
                    }
                }
                UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 5, options: .curveLinear) {
                    
                    for item in snapshots {
                        item.snapShot.frame = item.toFrame
                    }
                    toView.alpha = 1
                } completion: { (flag) in
                    for item in snapshots {
                        item.fromView.isHidden = false
                        item.toView.isHidden = false
                        item.snapShot.isHidden = true
                    }
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                }

            }
            
        } else {
            
            var snapshots = [TransitionItem]()
            if let fromContainer = fromVC?.transitionContainer,
               let toContainer = toVC?.transitionContainer {
                for key in fromContainer.keys {
                    if let fromV = fromContainer.dic[key], let toV = toContainer.dic[key] {
                        let img = fromV.screenshot
                        let imageView = UIImageView(image: img)
                        fromV.isHidden = true
                        // 转换 frame
                        let fromFrame = fromV.superview?.convert(fromV.frame, to: container)
                        imageView.frame = fromFrame!
                        let toFrame = toV.superview?.convert(toV.frame, to: container)
                        container.addSubview(imageView)
                        
                        print(toV.frame)
                        
                        toV.isHidden = true
                        let transitionItem = TransitionItem(fromView: fromV, toView: toV, snapShot: imageView, toFrame: toFrame)
                        snapshots.append(transitionItem)
                    }
                    
                }
            }
            
            
            if let fromView = fromVC?.view,
               let toView = toVC?.view {
                UIView.animate(withDuration: 0.25) {
                    
                    for item in snapshots {
                        item.snapShot.frame = item.toFrame
                    }
                    fromView.alpha = 0
                } completion: { (flag) in
                    for item in snapshots {
                        item.fromView.isHidden = false
                        item.toView.isHidden = false
                        item.snapShot.isHidden = true
                    }
                    if flag {
                        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                    }
                    
                }
            }
        }
    }
}


struct TransitionItem {
    var fromView: UIView!
    var toView: UIView!
    var snapShot: UIImageView!
    var toFrame: CGRect!
}


extension UIView {
    var screenshot: UIImage? {
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, 0)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        layer.render(in: context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
