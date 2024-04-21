//
//  ViewController.swift
//  SearchableTableView
//
//  Created by Yernar Baiginzheyev on 21.04.2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var table: UITableView!
    @IBOutlet var field: UITextField!
    
    var data = [String]()
    var filteredData = [String]()
    var filtered = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        field.delegate = self
        setupData()
    }
    private func setupData(){
        let names = ["Alice", "Bob", "Charlie", "David", "Eva", "Frank", "Grace", "Henry", "Ivy", "Jack",
                 "Katherine", "Liam", "Mia", "Noah", "Olivia", "Peter", "Quinn", "Rachel", "Samuel", "Tina"]

        data.append(contentsOf: names)
    }
    
    private func filterText(_ query: String) {
        filteredData.removeAll()
        
        for name in data {
            if name.lowercased().starts(with: query.lowercased()) {
                filteredData.append(name)
            }
        }
        table.reloadData()
        filtered = true
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !filteredData.isEmpty {
            return filteredData.count
        }
        return filtered ? 0 : data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if !filteredData.isEmpty {
            cell.textLabel?.text = filteredData[indexPath.row]
        } else {
            cell.textLabel?.text = data[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text  {
            filterText(text + string)
        }
        return true
    }
}

