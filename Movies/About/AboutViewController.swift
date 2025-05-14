//
//  AboutViewController.swift
//  Movies
//
//  Created by Aleksandra Axeltra on 14.5.25.
//

import UIKit
import SwiftUI

struct AboutScreen: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> AboutViewController {
        return AboutViewController()
    }

    func updateUIViewController(_ uiViewController: AboutViewController, context: Context) {}
}

class AboutViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        let label = UILabel()
        label.text = "This screen was built using UIKit"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
