//
//  ViewController.swift
//  Davaleba_25_mitchelidze
///
//  Created by michelidze'smacbook on 28.02.23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private weak var monkeyImageView: UIImageView!
    @IBOutlet private weak var bananaImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addPangesture(view: monkeyImageView)
        addTapGesture(view: bananaImageView)
    }
    
    func addTapGesture(view: UIView) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        bananaImageView.addGestureRecognizer(tapGesture)
    }
    
    func addPangesture(view: UIView) {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        monkeyImageView.addGestureRecognizer(panGesture)
    }
    
    @objc func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
        
        UIView.animate(withDuration: 1.0) {
            self.bananaImageView.center.y = self.monkeyImageView.center.y
        } completion: { _ in
            let bananaFrame = self.bananaImageView.convert(self.bananaImageView.bounds, to: self.view)
            let monkeyFrame = self.monkeyImageView.convert(self.monkeyImageView.bounds, to: self.view)
            if monkeyFrame.intersects(bananaFrame) {
                let alert = UIAlertController(title: "You win", message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Close", style: .default))
                alert.addAction(UIAlertAction(title: "Start Over", style: .default, handler: { _ in
                    self.resetView()
                }))
                self.present(alert, animated: true)
            } else {
                let alert = UIAlertController(title: "You lose", message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Close", style: .default))
                alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: { _ in
                }))
                self.present(alert, animated: true)
                self.resetView()
            }
        }

    }
    
    func resetView() {
        let bananaInitialCenter = CGPoint(x: 100, y: 100)
        let monkeyInitialCenter = CGPoint(x: 310, y: 720)
        //ეს ყველა დევაისზე არ იმუშავებს ალბათ, მეტად ამ ეტაპზე ვერ მოვიფიქრე როგორ დამერესტებინა ვიუ
        bananaImageView.center = bananaInitialCenter
        monkeyImageView.center = monkeyInitialCenter
    }
    
    @objc func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
        let translation = gestureRecognizer.translation(in: self.view)
        monkeyImageView.center = CGPoint(x: monkeyImageView.center.x + translation.x, y: monkeyImageView.center.y)
        gestureRecognizer.setTranslation(CGPoint.zero, in: self.view)
        
        
    }


}
