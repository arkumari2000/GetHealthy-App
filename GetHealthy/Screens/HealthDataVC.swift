//
//  HealthDataVC.swift
//  GetHealthy
//
//  Created by Archana Kumari on 16/09/25.
//

import UIKit

class HealthDataVC: UIViewController {

    private var activityData: [Activity] = []
    private let healthTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        requestAuthorization()
        configureTableView()
    }
    
    func configureVC() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Your Activity Data"
    }
    
    func requestAuthorization() {
        HealthKitManager.shared.requestAuthorization { [weak self] success, error in
            DispatchQueue.main.async {
                if success {
                    self?.fetchAllData()
                } else {
                    let alert = UIAlertController(title: "Error", message: "HealthKit authorization failed.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self?.present(alert, animated: true)
                }
            }
        }
    }
    
    private func fetchAllData() {
        HealthKitManager.shared.fetchTodayActivities { activities in
            self.activityData.append(contentsOf: activities)
            DispatchQueue.main.async {
                self.healthTableView.reloadData()
            }
        }
    }
    
    
    func configureTableView() {
        healthTableView.register(ActivityTVC.self, forCellReuseIdentifier: ActivityTVC.reuseId)
        healthTableView.dataSource = self
        healthTableView.delegate = self
        healthTableView.separatorStyle = .none
        healthTableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(healthTableView)
        NSLayoutConstraint.activate([
            healthTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            healthTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            healthTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            healthTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
        ])
    }
    
}

extension HealthDataVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activityData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ActivityTVC.reuseId, for:  indexPath) as? ActivityTVC, let activity = activityData[safe: indexPath.item] else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.set(activityData: activity)
        return cell
    }
}
