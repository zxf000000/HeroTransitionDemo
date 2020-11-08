//
//  ViewController.swift
//  HeroDemo
//
//  Created by mr.zhou on 2020/11/6.
//

import UIKit

class ViewController: UIViewController {

    let tableView = UITableView()
    
    var transitionDelegate: TransitionDelegate!
    var percent: UIPercentDrivenInteractiveTransition = UIPercentDrivenInteractiveTransition()
    let secondVC = SecondViewController()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.delegate = self.transitionDelegate

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let blueView = UIImageView()
        blueView.frame = CGRect(x: 100, y: 88, width: 100, height: 100)
        blueView.image = UIImage(named: "1")
        blueView.contentMode = .scaleAspectFill
        blueView.layer.masksToBounds = true
        view.addSubview(blueView)
        self.addTransitionView(blueView, key: "blue")

        let view2 = UIImageView()
        view2.image = UIImage(named: "1")
        view2.contentMode = .scaleAspectFill
        view2.layer.masksToBounds = true
        view.addSubview(view2)
        view2.frame = CGRect(x: 200, y: 400, width: 100, height: 100)
        addTransitionView(view2, key: "red")
        
        self.transitionDelegate = TransitionDelegate(present: Transition(true), dismiss: Transition(false), interPresent: percent, interDismiss: percent)
//        secondVC.navigationController?.delegate = self.transitionDelegate
//        secondVC.modalPresentationStyle = .custom
//        secondVC.transitioningDelegate = transitionDelegate
        secondVC.percent = percent
        secondVC.transitionDelegate = transitionDelegate
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        view.addGestureRecognizer(pan)
        
//        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
//        view.addGestureRecognizer(swipe)
                
        let button = UIButton()
        button.setTitle("tap", for: .normal)
        button.backgroundColor = .black
        button.frame = CGRect(x: 100, y: 200, width: 100, height: 59)
        button.addTarget(self, action: #selector(tapButton), for: .touchDown)
        view.addSubview(button)
    }
    
    @objc
    func tapButton() {
        transitionDelegate.isTap = true
//        present(secondVC, animated: true, completion: nil)
        navigationController?.pushViewController(secondVC, animated: true)
    }
    
    @objc
    func handleSwipe(_ swipe: UISwipeGestureRecognizer) {
        switch swipe.state {
        case .began:
            break
        case .changed:
            break
        default:
            transitionDelegate.isTap = true
            present(secondVC, animated: true, completion: nil)
        }
    }
    
    @objc
    func handlePan(_ pan: UIPanGestureRecognizer) {
        let transition = pan.translation(in: view)
                
        switch pan.state {
        case .began:
            transitionDelegate.isTap = false
//            present(secondVC, animated: true, completion: nil)
            navigationController?.pushViewController(secondVC, animated: true)

        case .changed:
            percent.update(-(transition.y) / (view.bounds.height - 200))
            break
        default:
            if -transition.y / (view.bounds.height - 200) > 0.5 {
                percent.finish()
            } else {
                percent.cancel()
            }
            break
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = SecondViewController()
        present(vc, animated: true, completion: nil)
    }
}

class TestCell: UITableViewCell {
    
    var didTapRed: (() -> Void)?
    
    let redView = UIView()
    let blueView = UIView()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        redView.backgroundColor = .red
        blueView.backgroundColor = .blue

        redView.frame = CGRect(x: 10, y: 10, width: 50, height: 50)
        blueView.frame = CGRect(x: 70, y: 10, width: 100, height: 100)
        
        contentView.addSubview(redView)
        contentView.addSubview(blueView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

