//
//  ListType_UnitTest.swift
//  StarWarsPocketGuideTests
//
//  Created by RICHARD MONSON-HAEFEL on 11/19/17.
//  Copyright © 2017 RICHARD MONSON-HAEFEL. All rights reserved.
//  swiftlint:disable identifier_name explicit_top_level_acl explicit_type_interface

import XCTest
@testable import StarWarsPocketGuide

class ListTypeUnitTest: XCTestCase {

    let stringUrls = ["http://www.example.com/test1/", "http://www.example.com/test2"]

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testAssignments_correctAssociatedValues() {

        func assignment_Helper(listType: ListType) {
            switch listType {
            case .Characters(let urls):
                XCTAssert(urls == stringUrls, "ListType.Characters is not working properly")
            case .Films(let urls):
                XCTAssert(urls == stringUrls, "ListType.Films is not working properly")
            case .Planets(let urls):
                XCTAssert(urls == stringUrls, "ListType.Planets is not working properly")
            case .Ships(let urls):
                XCTAssert(urls == stringUrls, "ListType.Planets is not working properly")
            case .Species(let urls):
                XCTAssert(urls == stringUrls, "ListType.Species is not working properly")
            case .Vehicles(let urls):
                XCTAssert(urls == stringUrls, "ListType.Vehicels is not working properly")
            }
        }

        assignment_Helper(listType: .Characters(urls: stringUrls))
        assignment_Helper(listType: .Films(urls: stringUrls))
        assignment_Helper(listType: .Planets(urls: stringUrls))
        assignment_Helper(listType: .Ships(urls: stringUrls))
        assignment_Helper(listType: .Vehicles(urls: stringUrls))

    }

}
