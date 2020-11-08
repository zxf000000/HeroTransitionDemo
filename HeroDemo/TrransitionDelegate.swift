//
//  TrransitionDelegate.swift
//  HeroDemo
//
//  Created by mr.zhou on 2020/11/8.
//

import Foundation
import UIKit

class TransitionDelegate: NSObject, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {
    
    var isTap: Bool = false
    
    var present: UIViewControllerAnimatedTransitioning!
    var dismiss: UIViewControllerAnimatedTransitioning!
    var interPresent: UIViewControllerInteractiveTransitioning!
    var interDismiss: UIViewControllerInteractiveTransitioning!
    init(present: UIViewControllerAnimatedTransitioning, dismiss: UIViewControllerAnimatedTransitioning, interPresent: UIViewControllerInteractiveTransitioning, interDismiss: UIViewControllerInteractiveTransitioning) {
        self.present = present
        self.dismiss = dismiss
        self.interPresent = interPresent
        self.interDismiss = interDismiss
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self.present
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self.dismiss
    }

    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if isTap {
            return nil
        } else {
            return self.interPresent
        }
        
    }

    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {

        if isTap {
            return nil
        } else {
            return self.interDismiss
        }
    }
    
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if isTap {
            return nil
        } else {
            return self.interPresent
        }
    }

    
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            return Transition(true)
        } else {
            return Transition(false)
        }
    }
}
