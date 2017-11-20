//
//  LandingVC.swift
//  StarWarsPojectGuide
//
//  Created by RICHARD MONSON-HAEFEL on 11/8/17.
//  Copyright © 2017 RICHARD MONSON-HAEFEL. All rights reserved.
//

import UIKit
import StarWarsAPI

public class LandingCell: UITableViewCell {
    static let identifier: String = "LandingCell"

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    private var _film: Film?
    var film: Film? {
        set {
            self._film = newValue
            self.titleLabel.text = _film?.title
            let imageFilename = "episode\(_film?.episode_id ?? 0)"
            self.imgView.image = UIImage(named: imageFilename)
        }
        get {
            return self._film
        }
    }

}

/**
 The `LandingVC` is the first screen a user will see when launching the
 *StarWarsAPI Pocket Guide*. This view navigates to the `FilmVC` view when a film
 title is selected.
 
 This view controller orders and displays the film
 titles returned by the StarWarsAPI Films REST call documented
 [here](https://swapi.co/documentation#films) at the StarWarsAPI.co web site
 */
public class LandingVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Properties
    var films: [Film] = []
    var LandingVC_to_FilmVC_Segue: String = "LandingVC_to_FilmVC_Segue"

    // MARK: - IBOutlets
    @IBOutlet weak var mastheadImg: UIImageView!
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Layout
    override public var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override public func viewDidLoad() {
        super.viewDidLoad()

        ActivityIndicator.shared.showActivityIndicator(forView: self.view)
        StarWarsAPI.shared.films { (films, error) in
            guard error == nil else {

                // set films to an empty set so that the application doesn't blow up if the call failed.
                self.films = []
                self.showAlert(title: "Data Access Error", message: "The applicaiton is unable to retreive data at this time. Please try again later.")
                return
            }

            guard let films = films else {

                // set films to an empty set so that the application doesn't blow up if the call failed.
                self.films = []
                self.showAlert(title: "Data Access Error", message: "The applicaiton is unable to retreive data at this time. Please try again later.")
                return
            }
            self.tableView.delegate = self
            self.tableView.dataSource = self

            self.films = films.sorted {
                $0.episode_id! < $1.episode_id!
            }
            self.tableView.reloadData()

            defer {

                ActivityIndicator.shared.hideActivityIndicator()

            }

        }
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    // MARK: - Table view delegate
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView.frame.size.width * 98 / 500
    }

    // MARK: - Table view data source

    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return films.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LandingCell.identifier, for: indexPath) as? LandingCell
        cell?.film = self.films[indexPath.row]
        return cell!

    }

    // MARK: - Navigation

    public override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return identifier == LandingVC_to_FilmVC_Segue
    }

    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == LandingVC_to_FilmVC_Segue {
            if  let filmVC = segue.destination as? FilmVC,
                let landingCell = sender as? LandingCell,
                let film = landingCell.film {
                filmVC.film = film
            }
        }
    }
}
