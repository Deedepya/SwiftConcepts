//
//  SearchViewController.swift
//  WeatherApp
//
//  Created by dedeepya reddy salla on 04/06/23.
//

import UIKit

let reuseIdentifier = "CityTableViewCellReuse"

protocol SearchVCProtocol: AnyObject {
    func selectedItem(item: String)
}

class SearchViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var tableview: UITableView!
    
    // MARK: - properties
    private var searchList: [String] = []
    var originalList: [String] = []
    var searchText: String = "" {
      didSet {
          updateSearchResults()
      }
    }
    weak var delegate: SearchVCProtocol?

    // MARK: - UI setup
    override func viewDidLoad() {
        super.viewDidLoad()
        searchList = originalList
        setUpUI()
    }
    
    func setUpUI() {
        tableview.dataSource = self
        tableview.delegate = self
        let cityCell = String(describing: CityTableViewCell.self)
        tableview.register(UINib(nibName: cityCell, bundle: nil), forCellReuseIdentifier: DataStorageConstants.CellReuseIdentifiers.citycell)
    }

    func updateSearchResults() {
        searchList = originalList.filter {$0.contains(searchText)}
        tableview.reloadData()
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension SearchViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DataStorageConstants.CellReuseIdentifiers.citycell, for: indexPath) as! CityTableViewCell
        cell.cityLabel.text = searchList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.selectedItem(item: searchList[indexPath.row])
    }
}
