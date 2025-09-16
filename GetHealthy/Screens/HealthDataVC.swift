//
//  HealthDataVC.swift
//  GetHealthy
//
//  Created by Archana Kumari on 16/09/25.
//

import UIKit

class HealthDataViewController: UIViewController {
    private let authorizeButton = UIButton(type: .system)
    private let stackView = UIStackView()
    
    // Create reusable info views for each activity. Placeholders for now.
    private let cyclingView = ActivityInfoView(label: "Cycling", icon: UIImage(named: "cycling_icon"), data: "- km")
    private let walkingView = ActivityInfoView(label: "Walking", icon: UIImage(named: "walking_icon"), data: "- km")
    private let runningView = ActivityInfoView(label: "Running", icon: UIImage(named: "running_icon"), data: "- km")
    private let energyView  = ActivityInfoView(label: "Energy",  icon: UIImage(named: "energy_icon"),  data: "- kcal")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        // Configure authorize button
        authorizeButton.setTitle("Authorize HealthKit", for: .normal)
        authorizeButton.addTarget(self, action: #selector(authorizeTapped), for: .touchUpInside)
        authorizeButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Configure the vertical stack view
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 24
        stackView.translatesAutoresizingMaskIntoConstraints = false
        // Add info views to the stack
        stackView.addArrangedSubview(cyclingView)
        stackView.addArrangedSubview(walkingView)
        stackView.addArrangedSubview(runningView)
        stackView.addArrangedSubview(energyView)
        
        // Add and constrain authorizeButton and stackView
        view.addSubview(authorizeButton)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            authorizeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            authorizeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: authorizeButton.bottomAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ])
    }
    
    @objc func authorizeTapped() {
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
        HealthKitManager.shared.fetchTodaySum(for: .distanceCycling, unit: .meter()) { [weak self] value in
            DispatchQueue.main.async {
                self?.cyclingView.configure(label: "Cycling", icon: UIImage(named: "cycling_icon"), data: String(format: "%.2f km", value / 1000))
            }
        }
        HealthKitManager.shared.fetchTodaySum(for: .distanceWalkingRunning, unit: .meter()) { [weak self] value in
            DispatchQueue.main.async {
                self?.walkingView.configure(label: "Walking", icon: UIImage(named: "walking_icon"), data: String(format: "%.2f km", value / 1000))
            }
        }
        // Running can use same as walking/running, or fetch separately if needed
        HealthKitManager.shared.fetchTodaySum(for: .distanceWalkingRunning, unit: .meter()) { [weak self] value in
            DispatchQueue.main.async {
                self?.runningView.configure(label: "Running", icon: UIImage(named: "running_icon"), data: String(format: "%.2f km", value / 1000))
            }
        }
        HealthKitManager.shared.fetchTodaySum(for: .activeEnergyBurned, unit: .kilocalorie()) { [weak self] value in
            DispatchQueue.main.async {
                self?.energyView.configure(label: "Energy", icon: UIImage(named: "energy_icon"), data: String(format: "%.0f kcal", value))
            }
        }
    }
}
