//
//  UIViewController+TransitionContainer.swift
//  HeroDemo
//
//  Created by mr.zhou on 2020/11/8.
//

import Foundation
import UIKit

var transitionContainerKey = ""
extension UIViewController {
    var transitionContainer: [String: UIView] {
        set {
            objc_setAssociatedObject(self, &transitionContainerKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &transitionContainerKey) as? [String: UIView] ?? [String: UIView]()
        }
    }
    
    func addTransitionView(_ view: UIView, key: String) {
        var dic = self.transitionContainer
        dic[key] = view
        transitionContainer = dic
    }
}
