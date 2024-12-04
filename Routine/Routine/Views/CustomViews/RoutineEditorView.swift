//
//  RoutineEditorView.swift
//  Routine
//
//  Created by mun on 12/1/24.
//

import UIKit

import SnapKit

// 루틴 생성 및 수정(삭제) View
class RoutineEditorView: UIView {

    // MARK: - 프로퍼티 생성

    // 상단 바 view
    let headerStackView: UIStackView = {
        let stackView = UIStackView()
        // TODO: -
        return stackView
    }()

    // 뒤로가기 Button
    let backButton: UIButton = {
        let button = UIButton()
        // TODO: - 네비게이션 뒤로가기를 오버라이딩 할 수 있는지 확인
        return button
    }()

    // 제목 Label
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "루틴 추가"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 25)
        label.textAlignment = .center
        label.backgroundColor = .yellow
        return label
    }()

    // 삭제 Button
    let deleteButton: UIButton = {
        let button = UIButton()
        // TODO: -
        return button
    }()

    // 컬러, 타이틀, 스티커가 있는 stackView
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        return stackView
    }()

    // 컬러 이미지, 이름이 있는 View
    let colorView: UIView = {
        let view = UIView()
        return view
    }()

    // 컬러 View
    let colorImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = 35 / 2
        return imageView
    }()

    // 컬러 label
    let colorLabel: UILabel = {
        let label = UILabel()
        label.text = "컬러"
        label.textColor = .black
        label.font = .systemFont(ofSize: 15)
        return label
    }()

    // 타이틀 입력 View
    let titleInputView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        return view
    }()

    // 타이틀 입력 textField
    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "타이틀 입력"
        textField.font = .systemFont(ofSize: 15)
        return textField
    }()

    // 타이틀 입력 이미지
    let titleInputImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "gamecontroller")?.withRenderingMode(.alwaysOriginal)
        imageView.contentMode = .scaleAspectFill

        return imageView
    }()

    // 스티커 이미지, 스티커 이름이 있는 view
    let stickerView: UIView = {
        let view = UIView()
        return view
    }()

    // 스티커 imageView
    let stickerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = 35 / 2
        return imageView
    }()

    // 스티커 label
    let stickerLabel: UILabel = {
        let label = UILabel()
        label.text = "스티커"
        label.textColor = .black
        label.font = .systemFont(ofSize: 15)
        return label
    }()

    // TODO: - 스케줄 넣을 테이블 뷰 생성

    // TODO: - 추가하기 하단 바 생성

    // MARK: - 초기화

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - 레이아웃 설정

    private func configureUI() {
        [titleLabel, stackView].forEach {
            self.addSubview($0)
        }

        [colorView, titleInputView, stickerView].forEach {
            stackView.addArrangedSubview($0)
        }

        [colorImage, colorLabel].forEach {
            colorView.addSubview($0)
        }

        [titleTextField, titleInputImage].forEach {
            titleInputView.addSubview($0)
        }

        [stickerImage, stickerLabel].forEach {
            stickerView.addSubview($0)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(80)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(200)
        }

        stackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(50)
            $0.width.equalToSuperview()
            $0.height.equalTo(150)
        }

        colorView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(50)
            $0.height.equalTo(150)
            $0.width.equalTo(130)
        }

        colorImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-10)
            $0.width.height.equalTo(35)
        }

        colorLabel.snp.makeConstraints {
            $0.top.equalTo(colorImage.snp.bottom)
            $0.height.equalTo(40)
            $0.centerX.equalToSuperview()
        }

        titleInputView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(50)
            $0.height.equalTo(150)
            $0.width.equalTo(130)
        }

        titleTextField.snp.makeConstraints {
            $0.height.equalTo(100)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-20)
        }

        titleInputImage.snp.makeConstraints {
            $0.top.equalTo(titleTextField.snp.bottom).offset(10)
            $0.height.equalTo(40)
            $0.centerX.bottom.equalToSuperview()
        }

        stickerView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(50)
            $0.height.equalTo(150)
            $0.width.equalTo(130)
        }

        stickerImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-10)
            $0.width.height.equalTo(35)
        }

        stickerLabel.snp.makeConstraints {
            $0.top.equalTo(colorImage.snp.bottom)
            $0.height.equalTo(40)
            $0.centerX.equalToSuperview()
        }

    }

}
