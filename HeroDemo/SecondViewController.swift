//
//  SecondViewController.swift
//  HeroDemo
//
//  Created by mr.zhou on 2020/11/6.
//

import UIKit

class SecondViewController: UIViewController {

    let redView = UIView()
    var percent: UIPercentDrivenInteractiveTransition = UIPercentDrivenInteractiveTransition()
    weak var transitionDelegate: TransitionDelegate!
    init() {
        super.init(nibName: nil, bundle: nil)
 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        
        redView.backgroundColor = .blue
        redView.frame = CGRect(x: 10, y: 200, width: 200, height: 200)
        view.addSubview(redView)
        addTransitionView(redView, key: "blue")

        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        view.addGestureRecognizer(pan)
        
        
    }
    @objc
    func handlePan(_ pan: UIPanGestureRecognizer) {
        let transition = pan.translation(in: view)
        
        print(transition)
        
        switch pan.state {
        case .began:
            transitionDelegate.isTap = false
            dismiss(animated: true, completion: nil)
        case .changed:
            percent.update((transition.y) / (view.bounds.height - 200))
            break
        default:
            if transition.y / (view.bounds.height - 200) > 0.5 {
                percent.finish()
            } else {
                percent.cancel()
            }
            break
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
