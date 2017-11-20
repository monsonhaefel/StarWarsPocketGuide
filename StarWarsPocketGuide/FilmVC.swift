//
//  FilmVC.swift
//  StarWarsPojectGuide
//
//  Created by RICHARD MONSON-HAEFEL on 11/6/17.
//  Copyright © 2017 RICHARD MONSON-HAEFEL. All rights reserved.
//  swiftlint:disable force_cast

import UIKit
import StarWarsAPI

/**
 The `FilmVC` is reached as a detail screen displaying information about the
 film selected from the `LandingVC' table view.
 
 The model for this screen is the Film object passed from the `LandingVC` to the
 `film` property when a film is selected and a segue to this screen is activated.
 The film data, collected and marshaled into the Film model object, is accessed
 returned by the StarWarsAPI Films REST call documented
 [here](https://swapi.co/documentation#films) at the StarWarsAPI.co web site
 
 This view allows navigation back to the `LandingVC' as well as deeper to the
 `GeneralListVC` view when a listing (i.e., Characters, Species, Planets, Vehicles, Spaceships) cells are
 selected in the embedded table view.
 */
internal class FilmVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Properties
    let FilmVC_to_GeneralListVC_Segue: String = "FilmVC_to_GeneralListVC_Segue"
    var selectedListType: ListType?
    var film: Film?

    // MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var directorNameLabel: UILabel!
    @IBOutlet weak var producerNameLabel: UILabel!
    @IBOutlet weak var propsNavigationTable: UITableView!
    @IBOutlet weak var crawlTextArea: UITextView!

    // MARK: - VC Loading
    override func viewDidLoad() {
        super.viewDidLoad()

        guard film != nil else {
            showAlert(title: "Data Access Error", message: "The applicaiton is unable to retreive data at this time. Please try again later.")
            return
        }

        releaseDateLabel.text = film?.release_date ?? ""
        directorNameLabel.text = film?.director ?? "Unknown"
        producerNameLabel.text = film?.producer ?? "Unknown"
        crawlTextArea.text = film?.opening_crawl ?? "No opening craw is available"

        let barImage = UIImage(named: "starwarsnavbanner")//named: imageFilename)
        self.navigationController?.navigationBar.setBackgroundImage(barImage?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .tile), for: .default)

        self.titleLabel.text = film?.title
        self.crawlTextArea.backgroundColor = UIColor.black
        self.crawlTextArea.textColor = UIColor.white

        // This is a workaround to prevent the table from showing empty rows
        let footer = UIView()
        propsNavigationTable.tableFooterView = footer
        propsNavigationTable.delegate = self
        propsNavigationTable.dataSource = self
        propsNavigationTable.reloadData()
    }

    // MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PropsNavigationCell.identifier, for: indexPath) as! PropsNavigationCell

        switch indexPath.row {
        case 0:
            cell.filmTitle.text = "Characters"
            let img = UIImage(named: "characters")
            cell.imageBackground.setImageWithAlphaGradiant(image: img!)
        case 1:
            cell.filmTitle?.text = "Species"
            let img = UIImage(named: "species")
            cell.imageBackground.setImageWithAlphaGradiant(image: img!)
        case 2:
            cell.filmTitle?.text = "Planets"
            let img = UIImage(named: "planets")
            cell.imageBackground.setImageWithAlphaGradiant(image: img!)
        case 3:
            cell.filmTitle?.text = "Ships"
            let img = UIImage(named: "ships")
            cell.imageBackground.setImageWithAlphaGradiant(image: img!)
        case 4:
            cell.filmTitle?.text = "Vehicles"
            let img = UIImage(named: "vehicles")
            cell.imageBackground.setImageWithAlphaGradiant(image: img!)
        default:
            cell.filmTitle?.text = "Unknown"
        }
        return cell
    }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        switch indexPath.row {
        case 0://"Characters"
            selectedListType = ListType.Characters(urls: (film?.characters)!)
        case 1://"Species"
            selectedListType = ListType.Species(urls: (film?.species)!)
        case 2://"Planets"
            selectedListType = ListType.Planets(urls: (film?.planets)!)
        case 3://"Ships"
            selectedListType = ListType.Ships(urls: (film?.starships)!)
        case 4://"Vehicles"
            selectedListType = ListType.Vehicles(urls: (film?.vehicles)!)
        default://"Unknown"
            return
        }

        performSegue(withIdentifier: FilmVC_to_GeneralListVC_Segue, sender: nil)

    }

    // MARK: - Navigation

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return identifier == FilmVC_to_GeneralListVC_Segue
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if selectedListType != nil {
            if  let generaListVc = segue.destination as? GeneralListVC {

                generaListVc.displayData = (selectedListType!, film!)

            }
        }
    }

}
