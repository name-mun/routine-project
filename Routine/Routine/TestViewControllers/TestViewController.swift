//
//  ViewController.swift
//  Routine
//
//  Created by t2023-m0072 on 10/27/24.

import UIKit
import SnapKit

class TestViewController: UIViewController {

    let goModal = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureModalButton()
    }
    
    private func configureModalButton() {
        goModal.backgroundColor = .black
        
        view.addSubview(goModal)
        
        goModal.addTarget(self, action: #selector(goNext), for: .touchDown)
        goModal.snp.makeConstraints() {
            $0.center.equalToSuperview()
            
        }
    }
    
    @objc
    func goNext() {
        let modalVC = RoutineSuggestionViewController()
        
        modalVC.modalPresentationStyle = .automatic
        present(modalVC,animated: true,completion: nil)
        
    }
    
}


#Preview("TestViewController") {
    TestViewController()
}
