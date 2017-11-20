//
//  Enumerations.swift
//  StarWarsPojectGuide
//
//  Created by RICHARD MONSON-HAEFEL on 11/6/17.
//  Copyright © 2017 RICHARD MONSON-HAEFEL. All rights reserved.
//

import Foundation

/**
 This enumeration is used when navigating from the `FilmVC` view to the
 `GeneralListVC` view. It identifies the type of characteristic (i.e. Characters,
 Species, Planets, Vehicles, Starships) to list and contains the URLs for each of
 objects it that list.
 */
public enum ListType {
    case Films(urls:[String])
    case Characters(urls:[String])
    case Species(urls:[String])
    case Planets(urls:[String])
    case Ships(urls:[String])
    case Vehicles(urls:[String])
}
