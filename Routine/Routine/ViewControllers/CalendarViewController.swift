//
//  CalendarViewController.swift
//  Routine
//
//  Created by mun on 12/1/24.
//

import UIKit

import SnapKit

// 날짜 선택 화면 ViewController (모달)
class CalendarViewController: UIViewController {
    
    var onDatePick: ((Date) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
    
        [
            datePicker,
        ].forEach {
            self.view.addSubview($0) }
        
        datePicker.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(400)
        }

    }
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        
        datePicker.preferredDatePickerStyle = .inline
        datePicker.datePickerMode = .date
        datePicker.contentMode = .scaleAspectFill
        
        return datePicker
    }()
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        let date = self.datePicker.date
        
        onDatePick?(date)
    }
    
}

#Preview {
    CalendarViewController()
}
