//
//  RoutineSuggestionViewController.swift
//  Routine
//
//  Created by mun on 11/3/24.
//

import UIKit
import SnapKit

class RoutineSuggestionViewController: UIViewController {

    let pageTitle = UILabel()
    let pageDescription = UILabel()
    let tableView = UITableView(frame: .zero, style: .grouped)
    let addButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureLayout()
    }
    
    func configureUI() {
        view.backgroundColor = .white
        configurePageTitle()
        configureTableView()
        configureAddButton()
 
    }
    
    func configurePageTitle() {
        pageTitle.text = "루틴추천"
        pageTitle.textColor = .black
        pageTitle.font = .boldSystemFont(ofSize: 30)
        
        pageDescription.text = "오늘 날짜부터 루틴이 추가 돼요."
        pageDescription.textColor = .black
        pageDescription.font = .systemFont(ofSize: 15)
         
        [pageTitle, pageDescription].forEach {
            view.addSubview($0)
        }
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.backgroundColor = .white
        tableView.register(RoutineSuggestionTableViewCell.self, forCellReuseIdentifier: RoutineSuggestionTableViewCell.id)
        
        tableView.register(RoutineSuggestionTableHeader.self, forHeaderFooterViewReuseIdentifier: "RoutineSuggestionTableHeader")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    
    func configureAddButton() {
        addButton.setTitle("직접 만들기", for: .normal)
        addButton.titleLabel?.font = .boldSystemFont(ofSize: 17)
        addButton.backgroundColor = .black
        addButton.layer.cornerRadius = 25
        
        view.addSubview(addButton)
        
        addButton.addTarget(self, action: #selector(clickButton), for: .touchDown)
    }
 
    
    func configureLayout() {
        pageTitle.snp.makeConstraints {
            $0.top.equalToSuperview().inset(100)
            $0.leading.equalToSuperview().inset(20)
        }
         
        pageDescription.snp.makeConstraints {
            $0.top.equalTo(pageTitle.snp.bottom).offset(10)
            $0.leading.equalTo(pageTitle.snp.leading)
        }
           
           
        tableView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
            $0.top.equalTo(pageDescription.snp.bottom).offset(50)
            $0.trailing.equalToSuperview()
        }
        
        addButton.snp.makeConstraints() {
            $0.width.equalTo(150)
            $0.height.equalTo(50)
            $0.bottom.equalToSuperview().inset(40)
            $0.centerX.equalToSuperview()
        }
    }
    
    @objc
    func clickButton() {
        let newViewController = CreateRoutineViewController()
        
        let nav = self.presentingViewController as? UINavigationController
        
        nav?.pushViewController(newViewController, animated: true)
        
        self.dismiss(animated: true, completion: nil)

        //nextScreen.modalPresentationStyle = .fullScreen

        //present(nextScreen,animated: true,completion: nil)
                 //.navigationController?.pushViewController(nextScreen, animated: true)
        //navigationController?.pushViewController(nextScreen, animated: true)
        }
}
 
extension RoutineSuggestionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0 // RoutineSuggestionData.categoryCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "RoutineSuggestionTableHeader") as? RoutineSuggestionTableHeader else {
            return nil
        }
        
        headerView.configure (section)
                
        return headerView
    }
    
    func tableView(_ tableView:  UITableView, cellForRowAt indexPath:  IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RoutineSuggestionTableViewCell.id, for: indexPath) as! RoutineSuggestionTableViewCell
        cell.configure(indexPath[0])
        return cell
    }
     
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }
    
}

#Preview("RoutineSuggestionViewController") {
    RoutineSuggestionViewController()
}
 
