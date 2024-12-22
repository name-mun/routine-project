//
//  TestEditViewController.swift
//  Routine
//
//  Created by mun on 12/3/24.
//

import UIKit

import SnapKit

class TestEditViewController: UIViewController {

    let routineEditorView = RoutineEditorView()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }

    private func configureUI() {
        view.addSubview(routineEditorView)

        routineEditorView.snp.makeConstraints {
            $0.top.trailing.leading.bottom.equalToSuperview()
        }
    }

}
