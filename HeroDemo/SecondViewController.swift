//
//  SecondViewController.swift
//  HeroDemo
//
//  Created by mr.zhou on 2020/11/6.
//

import UIKit

class SecondViewController: UIViewController {

    let redView = UIImageView()
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
        redView.image = UIImage(named: "1")
        redView.contentMode = .scaleAspectFill
        redView.layer.masksToBounds = true
        view.addSubview(redView)
        addTransitionView(redView, key: "blue")

        
        let view2 = UIImageView()
        view2.image = UIImage(named: "1")
        view2.contentMode = .scaleAspectFill
        view2.layer.masksToBounds = true
        view.addSubview(view2)
        view2.frame = CGRect(x: 0, y: 300, width: 300, height: 300)
        addTransitionView(view2, key: "red")
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        view.addGestureRecognizer(pan)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(tapBack))
    }
    
    @objc
    func tapBack() {
        transitionDelegate.isTap = true
        navigationController?.popViewController(animated: true)
    }
    
    
    @objc
    func handlePan(_ pan: UIPanGestureRecognizer) {
        let transition = pan.translation(in: view)
                
        switch pan.state {
        case .began:
            transitionDelegate.isTap = false
//            dismiss(animated: true, completion: nil)
            navigationController?.popViewController(animated: true)
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
