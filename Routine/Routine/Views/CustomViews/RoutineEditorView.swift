//
//  RoutineEditorView.swift
//  Routine
//
//  Created by mun on 12/1/24.
//

import UIKit

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

    // 스케줄 넣을 StackView
    let scheduleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.layer.borderColor = UIColor.black.cgColor
        stackView.layer.borderWidth = 1
        return stackView
    }()

    // 반복 주기 view
    let repetationView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    // 반복 주기 label
    let repetationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "반복 주기"
        return label
    }()

    // 반복 주기 주간/월간 label
    let repetationWeeklyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "매주"
        label.textAlignment = .center
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.cornerRadius = 8
        label.font = .systemFont(ofSize: 14)
        return label
    }()

    // 반복 주기 요일 label
    let repetationDay: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "월, 화, 수, 목, 금, 토, 일"
        label.font = .systemFont(ofSize: 14)
        return label
    }()

    // 스택뷰 버튼 image
    let stackViewButtonImage: UIImageView = {
        let buttonImage = UIImageView()
        buttonImage.contentMode = .scaleAspectFill
        // buttonImage.layer.cornerRadius = 30 / 2
        buttonImage.image = UIImage(systemName: "checkmark.circle.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        return buttonImage
    }()


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
        [titleLabel, stackView, scheduleStackView].forEach {
            self.addSubview($0)
        }

        [colorView, titleInputView, stickerView].forEach {
            stackView.addArrangedSubview($0)
        }

        [repetationView].forEach {
            scheduleStackView.addArrangedSubview($0)
        }

        [repetationLabel, repetationWeeklyLabel, repetationDay, stackViewButtonImage].forEach {
            repetationView.addSubview($0)
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

        scheduleStackView.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).offset(60)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(30)
        }

        repetationView.snp.makeConstraints {
            $0.height.equalTo(70)
            $0.leading.trailing.top.bottom.equalToSuperview()
        }

        repetationLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }

        stackViewButtonImage.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(30)
        }

        repetationDay.snp.makeConstraints {
            $0.trailing.equalTo(stackViewButtonImage.snp.leading).offset(-7)
            $0.centerY.equalToSuperview()
        }

        repetationWeeklyLabel.snp.makeConstraints {
            $0.trailing.equalTo(repetationDay.snp.leading).offset(-7)
            $0.height.equalTo(30)
            $0.width.equalTo(35)
            $0.centerY.equalToSuperview()
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
    */

}

#Preview("TestEditViewController") {
    TestEditViewController()
}
