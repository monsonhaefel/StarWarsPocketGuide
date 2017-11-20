//
//  GeneralListVC.swift
//  StarWarsPojectGuide
//
//  Created by RICHARD MONSON-HAEFEL on 11/6/17.
//  Copyright © 2017 RICHARD MONSON-HAEFEL. All rights reserved.
//

import UIKit
import StarWarsAPI

/**
 The `GeneralListVC` is reached as a listing screen from the `FilmVC` after the
 user selects one of the following film characteristics: Characters, Species, Planets,
 Vehicles, or Spaceships.  It is a shared view table for all the types of lists
 (other than film titles) currently supported by this application.
 
 The `FilmVC` passes this class a list of the URLs for each of the items in the
 array of models (e.g. Starships) during a segue.  When the class receives the
 list of URLs it maps those to a call to the correct REST API collecting all of the
 models (of that type) for the entire website and filters this array for the
 movie selected. The `name` property for each model object is then displayed in
 this classes table.
 */
//  swiftlint:disable cyclomatic_complexity

internal class GeneralListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var listTypeLabel: UILabel!

    var displayObjects: [AnyObject]?

    var urlLookupStrings: [String]?

    private var _listType: ListType?
    private var _film: Film?

    var displayData: (ListType, Film)? {
        set {
            listType = newValue?.0
            film = newValue?.1
        }
        get {
            return (_listType!, _film!)
        }
    }

    var film: Film? {
        set {
            _film = newValue
        }
        get {
            return _film
        }
    }
    var listType: ListType? {
        set {
           _listType = newValue

            guard let _listType = _listType else {
                return
            }

            // Do any additional setup after loading the view.
            self.displayObjects = []
            self.urlLookupStrings = []

            // Generic is used to filter and sort the returned list of objects and load the table
            func processReturn<T: ModelObject>(results: [T]?, urlStrings: [String], error: StarWarsError?) {
                guard error == nil else {
                    showAlert(title: "Data Access Error", message: "The applicaiton is unable to retreive data at this time. Please try again later.")
                    return
                }
                guard let results = results else {
                    showAlert(title: "Data Access Error", message: "The applicaiton is unable to retreive data at this time. Please try again later.")
                    return
                }

                for item in results {
                    if urlStrings.contains(item.identifier()!) {
                        self.displayObjects?.append(item as AnyObject)
                    }
                }

                if let items = self.displayObjects as? [T] {
                    let sortedItems = items.sorted {
                        $0.sortValue()! < $1.sortValue()!
                    }
                    self.displayObjects = sortedItems as [AnyObject]
                    self.loadTable()
                } else {
                    return
                }
            }

            switch _listType {
            case .Characters(let urlStrings):
                StarWarsAPI.shared.people { (people, starWarsError) in
                    processReturn(results: people, urlStrings: urlStrings, error: starWarsError)
                }
            case .Species(urls: let urlStrings):
                StarWarsAPI.shared.species { (species, starWarsError) in
                    processReturn(results: species, urlStrings: urlStrings, error: starWarsError)
                }

            case .Planets(urls: let urlStrings):
                StarWarsAPI.shared.planets { (planets, starWarsError) in
                    processReturn(results: planets, urlStrings: urlStrings, error: starWarsError)
                }
            case .Vehicles(urls: let urlStrings):
                StarWarsAPI.shared.vehicles { (vehicles, starWarsError) in
                    processReturn(results: vehicles, urlStrings: urlStrings, error: starWarsError)
                }
            case .Ships(urls: let urlStrings):
                StarWarsAPI.shared.starships { (starships, starWarsError) in
                    processReturn(results: starships, urlStrings: urlStrings, error: starWarsError)
                }
            default:
                return
            }

        }
        get {
            return _listType
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.title = _film?.title

        switch _listType! {
        case .Characters:
            listTypeLabel.text = "Characters"
        case .Species:
            listTypeLabel.text = "Species"
        case .Planets:
            listTypeLabel.text = "Planets"
        case .Vehicles:
            listTypeLabel.text = "Vehicles"
        case .Ships:
            listTypeLabel.text = "Starships"
        default:
            listTypeLabel.text = "Unknown List Type"
        }

        ActivityIndicator.shared.showActivityIndicator(forView: self.view)
    }

    private func loadTable() {
        guard _listType != nil else {
            return
        }

        guard self.tableView != nil else {
            return
        }

        _loadTable()
    }

    private func _loadTable() {

        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()

        defer {

            ActivityIndicator.shared.hideActivityIndicator()

        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (displayObjects?.count) ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "GeneralListCell", for: indexPath)
        switch listType! {
        case .Characters:
            if let person = displayObjects![indexPath.row] as? People {
                cell.textLabel?.text = person.name

            }
        case .Species:
            if let species = displayObjects![indexPath.row] as? Species {
                cell.textLabel?.text = species.name
            }
        case .Planets:
            if let planet = displayObjects![indexPath.row] as? Planet {
                cell.textLabel?.text = planet.name
            }
        case .Vehicles:
            if let vehicle = displayObjects![indexPath.row] as? Vehicle {
                cell.textLabel?.text = vehicle.name
            }
        case .Ships:
            if let starship = displayObjects![indexPath.row] as? Starship {
                cell.textLabel?.text = starship.name
            }
        default:
            cell.textLabel?.text = "Unknown Item"
        }

        return cell
    }
}
