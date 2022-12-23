//
//  ViewController.swift
//  SwiftLintExample
//
//  Created by user on 10.12.2022.

import UIKit

class ViewController: UIViewController {
    // MARK: - trailing_newline
    // Type Contents Order

    // Non Triggering:
    // Type Aliases
    typealias CompletionHandler = ((TestEnum) -> Void)

    // Triggering:
    // Type Methods
    static func makeViewController() -> Bool {
        return true
    }

    // Subtypes
    class TestClass {
        // 10 lines
    }

    struct TestStruct {
        // 3 lines
    }

    enum TestEnum {
        // 5 lines
    }

    // Type Properties
    static let cellIdentifier: String = "AmazingCell"

    // Instance Properties
    var shouldLayoutView1: Bool = true
    var optionalVal: String? = "someString"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        examples()
    }
}

private extension ViewController {
    func examples() {
        // MARK: - control_statement
        // if, for, guard, switch, while, and catch statements shouldn’t unnecessarily
        // wrap their conditionals or arguments in parentheses.

        // Triggering:
        switch (shouldLayoutView1) {
        case true:
            return
        case false:
            return
        }

        // Non Triggering:
        if shouldLayoutView1 {

        }

        // MARK: - first_where
        // Prefer using .first(where:) over .filter { }.first in collections.

        let myList = [2, 3, 4]
        // Non Triggering:
        _ = myList.first(where: { $0 == 2 })

        // Triggering:
        _ = myList.filter { $0 % 2 == 0 }.first

        // MARK: - mark
        // MARK: comment should be in valid format. e.g. ‘// MARK: …’ or ‘// MARK: - …’
        // Triggering:
        // MARK: bad

        // MARK: - custom_todo
        // Triggering
        // TODO: - https://jira.com.tr/browse/TF-12033 issue
        // Triggering for todo and custom_todo:
        // TODO: - asdas

        _ = optionalVal!
    }
}
