//
//  ViewController.swift
//  mycrossword
//
//  Created by 曹肖鹏 on 2025/2/17.
//

import UIKit

class ViewController: UIViewController {
    private let startView = ResultView()
    private let crosswordView = CrosswordView()
    private let resultView = ResultView()
    private let playResultView = PlayResultView()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStartView()
    }
    
    private func setupStartView() {
        view.addSubview(startView)
        startView.translatesAutoresizingMaskIntoConstraints = false
        startView.delegate = self
        
        NSLayoutConstraint.activate([
            startView.topAnchor.constraint(equalTo: view.topAnchor),
            startView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            startView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            startView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupCrosswordView() {
        view.addSubview(crosswordView)
        crosswordView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            crosswordView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            crosswordView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            crosswordView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            crosswordView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension ViewController: StartViewDelegate {
    func didTapStartButton() {
        UIView.transition(with: view, duration: 0.3, options: .transitionCrossDissolve) {
            self.startView.removeFromSuperview()
            self.setupCrosswordView()
        }
    }
}

extension ViewController: ResultViewDelegate {
    func didTapPlayAgainButton() {
        UIView.transition(with: view, duration: 0.3, options: .transitionCrossDissolve) {
            self.resultView.removeFromSuperview()
            self.setupStartView()
        }
    }
    
    func showResults(score: Int) {
        view.addSubview(resultView)
        resultView.translatesAutoresizingMaskIntoConstraints = false
        resultView.delegate = self
        resultView.updateScore(score)
        
        NSLayoutConstraint.activate([
            resultView.topAnchor.constraint(equalTo: view.topAnchor),
            resultView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            resultView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            resultView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

