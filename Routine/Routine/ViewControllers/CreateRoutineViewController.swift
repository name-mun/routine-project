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

    private var selectedColorIndex = 0 // 선택된 색상 인덱스 저장

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

    // 액션 연결
    private func setupAction() {
        // 색상 버튼 액션 연결
        routineEditorView.colorButton.addAction(UIAction{ [weak self] _ in
            self?.colorButtonTapped()
        }, for: .touchUpInside)

        // 스티커 버튼 액션 연결
        routineEditorView.stickerButton.addAction(UIAction{ [weak self] _ in
            self?.stickerButtonTapped()
        }, for: .touchUpInside)
    }
}

// MARK: - 액션 설정

extension CreateRoutineViewController {
    // 색상 버튼 눌리면 실행
    private func colorButtonTapped() {
        let modalVC = SelectColorViewController()
        modalVC.delegate = self
        modalVC.setupIndex(selectedColorIndex)
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

    // 스티커 버튼 눌리면 실행
    private func stickerButtonTapped() {
        let modalVC = SelectStickerViewController()
        modalVC.delegate = self
        present(modalVC, animated: true)
    }
}

// MARK: - SelectColorViewController Delegate 설정

extension CreateRoutineViewController: SelectColorViewControllerDelegate {
    func updateColor(_ viewController: SelectColorViewController, color: [Double], selectedIndex: Int) {
        let rColor = color[0] / 256.0
        let gColor = color[1] / 256.0
        let bColor = color[2] / 256.0
        let colors = UIColor(red: rColor, green: gColor, blue: bColor, alpha: 1)
        routineEditorView.colorButton.backgroundColor = colors
        routineEditorView.titleInputView.backgroundColor = colors
        self.selectedColorIndex = selectedIndex
    }

}

// MARK: - SelectStickerViewController Delegate 설정

extension CreateRoutineViewController: SelectStickerViewControllerDelegate {
    func updateSticker(_ viewController: UIViewController, sticker: String) {
        routineEditorView.titleInputImage.image = UIImage(systemName: sticker)
    }

}
