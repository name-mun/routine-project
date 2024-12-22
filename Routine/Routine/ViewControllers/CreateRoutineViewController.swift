//
//  CreateRoutineViewController.swift
//  Routine
//
//  Created by mun on 12/1/24.
//

import UIKit

// 루틴 생성 화면 ViewController
class CreateRoutineViewController: UIViewController {

    let routineEditorView = RoutineEditorView()

    override func loadView() {
        super.loadView()

        view = routineEditorView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNav()
        setupAction()
    }

    private func configureNav() {
        self.navigationController?.navigationBar.isHidden = true
    }

    private func setupAction() {
        routineEditorView.colorButton.addAction(UIAction{ [weak self] _ in
            self?.colorButtonTapped()
        }, for: .touchUpInside)
    }
}

extension CreateRoutineViewController {
    private func colorButtonTapped() {
        let modalVC = SelectColorViewController()
        // 모달 화면 크기 설정
        if let sheet = modalVC.sheetPresentationController {
            if #available(iOS 16.0, *) {
                sheet.detents = [
                    .custom { _ in
                        return 250
                    }
                ]
            } else {
                sheet.detents = [.medium()]
            }
        }
        present(modalVC, animated: true)
    }
}
