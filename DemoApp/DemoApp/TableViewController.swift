//
//  TableViewController.swift
//  DemoApp
//
//  Created by Nicolás Miari on 2017/08/25.
//  Copyright © 2017 Nicolás Miari. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    fileprivate var activeHeadersBySection = [Int : UIView]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.separatorInset = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 0)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = "Section:\(indexPath.section) - Row:\(indexPath.row)"

        return cell
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let section = indexPath.section

        let cellFrame = tableView.rectForRow(at: indexPath)

        if row == 0 {
            let header = sectionHeader(forSection: section)

            // Top to first row (scroll with row), left to table:
            let topConstriant =  header.topAnchor.constraint(equalTo: tableView.topAnchor, constant: cellFrame.origin.y)
            topConstriant.priority = 10
            topConstriant.isActive = true

            header.leftAnchor.constraint(equalTo: tableView.leftAnchor).isActive = true

            // Top to superview (float at top until oushed out)
            guard let superview = self.view.superview else {
                return
            }
            let constant = self.tableView.contentInset.top
            let topConstraint2 = header.topAnchor.constraint(greaterThanOrEqualTo: superview.topAnchor, constant: constant)
            topConstraint2.priority = 100
            topConstraint2.isActive = true
        }

        let rowCount = self.tableView(tableView, numberOfRowsInSection: indexPath.section)

        if row == rowCount - 1 {
            let header = sectionHeader(forSection: section)

            let yCoordinate = cellFrame.origin.y + cellFrame.size.height

            // Bottom to last row of section (scroll out of screen with last row):
            let bottomConstraint = header.bottomAnchor.constraint(lessThanOrEqualTo: tableView.topAnchor, constant: yCoordinate)
            bottomConstraint.priority = 1000
            bottomConstraint.isActive = true
        }
    }

    func sectionHeader(forSection section: Int) -> UIView {
        guard let header = activeHeadersBySection[section] else {
            let header = dequeueReusableSectionHeaderView()
            header.translatesAutoresizingMaskIntoConstraints = false

            header.widthAnchor.constraint(equalToConstant: 30).isActive = true
            header.heightAnchor.constraint(equalToConstant: 30).isActive = true

            header.backgroundColor = (section % 2) == 0 ? UIColor.red : UIColor.green
            activeHeadersBySection[section] = header

            tableView.addSubview(header)

            return header
        }
        return header
    }

    private func dequeueReusableSectionHeaderView() -> UIView {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))

        return header
    }
}
