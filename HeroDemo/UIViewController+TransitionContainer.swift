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
    var transitionContainer: TransitionCotainer? {
        set {
            objc_setAssociatedObject(self, &transitionContainerKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &transitionContainerKey) as? TransitionCotainer
        }
    }
    
    
    func addTransitionView(_ view: UIView, key: String) {
        var container: TransitionCotainer?
        if self.transitionContainer == nil {
            container = TransitionCotainer()
            let dic = [key: view]
            container?.dic = dic
            container?.keys.append(key)
        } else {
            container = self.transitionContainer
            container?.dic[key] = view
            container?.keys.append(key)
        }
        
        transitionContainer = container
    }
}



class TransitionCotainer {
    var dic: [String: UIView] = [String: UIView]()
    var keys: [String] = [String]()
    init() {
        
    }
}
