//
//  ArrayGroupedTests.swift
//  PhotoUploaderTests
//
//  Created by Giovanni Catania on 03/08/21.
//

import XCTest
@testable import PhotoUploader

class ArrayGroupedTests: XCTestCase {
    func test_arrayStringGrouped_withEmptyInput() {
        let input: [String] = []
        let expected: [(String, [String])] = []
        
        let output = input.grouped
        
        XCTAssertEqual(output.count, expected.count)
    }
    
    func test_arrayStringGrouped_withNotEmptyInput() {
        let input: [String] = ["Italy", "France", "Ireland", "Japan"]
        let expected: [(String, [String])] = [("F", ["France"]),
                                              ("I", ["Ireland", "Italy"]),
                                              ("J", ["Japan"])]
        
        let output = input.grouped
        
        XCTAssertEqual(output.count, expected.count)
        XCTAssertEqual(output[0].0, expected[0].0)
        XCTAssertEqual(output[1].0, expected[1].0)
        XCTAssertEqual(output[2].0, expected[2].0)
        XCTAssertEqual(output[0].1, expected[0].1)
        XCTAssertEqual(output[1].1, expected[1].1)
        XCTAssertEqual(output[2].1, expected[2].1)
    }
}
