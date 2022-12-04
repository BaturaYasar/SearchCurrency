//
//  ViewController.swift
//  SearchApp
//
//  Created by Mehmet Baturay Yasar on 04/06/2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var countryArray = [Country]()
    var filteredCountryArray = [Country]()
    var isFiltered:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getJsonFile()
        setupTableView()
        setupTextField()
        addToolbar()
        
    }

    func getJsonFile() {
        if let pathUrl = Bundle.main.url(forResource: "Country", withExtension: "json") {
            do {
                let data = try Data(contentsOf: pathUrl)
                let decoder = JSONDecoder()
                let value = try decoder.decode([Country].self, from: data)
                self.countryArray = value
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print(error)
            }
            
        }
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        let uinib = UINib(nibName: "BasicTableViewCell", bundle: nil)
        tableView.register(uinib, forCellReuseIdentifier: "BasicTableViewCell")
    }
    
    @objc func doneTapped() {
        self.view.endEditing(true)
    }
    
    func addToolbar() {
        let bar = UIToolbar()
        let reset = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTapped))
        let resetTest = UIBarButtonItem(title: "Done2", style: .plain, target: self, action: #selector(doneTapped))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        bar.items = [reset,spacer,resetTest]
        bar.sizeToFit()
        textField.inputAccessoryView = bar
    }
    
    @objc func valueChanged(textField:UITextField) {
        if textField.text == "" {
            isFiltered = false
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }else {
            let searchText = textField.text ?? ""
            let filteredArray = self.countryArray.filter { country in
                country.name.lowercased().contains(searchText.lowercased())
            }
            self.filteredCountryArray = filteredArray
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func setupTextField() {
        textField.delegate = self
        textField.addTarget(self, action: #selector(valueChanged(textField:)), for: .editingChanged)
    }
}

// MARK: TableView

extension ViewController: UIApplicationDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltered == true {
            return filteredCountryArray.count
        }else {
            return countryArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasicTableViewCell", for: indexPath) as! BasicTableViewCell
        if isFiltered == true {
            let filteredCountry = filteredCountryArray[indexPath.row]
            cell.labelOutlet.text = filteredCountry.name
            cell.country = filteredCountry
        }else {
            let country = countryArray[indexPath.row]
            cell.labelOutlet.text = country.name
            cell.country = country
        }
        cell.delegate = self
        return cell
    }
}

extension ViewController:BasicTableViewCellDelegate {
    func didSelectButton(code: String) {
        let alert = UIAlertController(title: nil, message: code, preferredStyle: .alert)
        let done = UIAlertAction(title: "Done", style: .default)
        alert.addAction(done)
        self.present(alert, animated: true)
    }
}

// MARK: AAAAaAAAAA

extension ViewController:UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        isFiltered = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        isFiltered = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        print(string)
//        return true
//    }
    
}
