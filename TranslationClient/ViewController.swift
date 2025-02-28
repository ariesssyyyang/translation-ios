//
//  ViewController.swift
//  TranslationClient
//
//  Created by Aries on 2025/1/21.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}

private extension ViewController {
    func setupViews() {
        view.backgroundColor = .white

        let button = UIButton(type: .roundedRect, primaryAction: .init(title: "Show SwiftUI View", handler: { [weak self] _ in
            self?.addTranslationView()
        }))
        view.addSubview(button)
        button.bounds.size = .init(width: 200, height: 80)
        button.center = view.center
    }

    func addTranslationView() {
        let translationView = InstantTranslationView()
        let host = UIHostingController(rootView: translationView)
        host.view.backgroundColor = .white

        addChild(host)

        view.addSubview(host.view)
        host.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            host.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            host.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            host.view.leftAnchor.constraint(greaterThanOrEqualTo: view.leftAnchor, constant: 20),
            host.view.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: 20),
        ])

        host.didMove(toParent: self)
    }
}
