//
//  LinkListReducerTests.swift
//  PhotoUploaderTests
//
//  Created by Giovanni Catania on 03/08/21.
//

import XCTest
@testable import PhotoUploader

class LinkListReducerTests: XCTestCase {
    func test_linkListReducer_withGoToLinkListAction() {
        let input = LinkListState(links: [])
        let output = linkListReducer(action: GoToLinkList.init(list: ["https://catbox.moe/dhdhhd.jpg",
                                                                      "https://catbox.moe/dhdhhd.jpg"]),
                                     state: input)
        let expected = LinkListState(links: ["https://catbox.moe/dhdhhd.jpg",
                                             "https://catbox.moe/dhdhhd.jpg"])
        XCTAssertEqual(output, expected)
    }
    
    func test_linkListReducer_withBackToStartAction() {
        let input = LinkListState(links: ["https://catbox.moe/dhdhhd.jpg",
                                          "https://catbox.moe/dhdhhd.jpg"])
        let output = linkListReducer(action: BackToStart(),
                                     state: input)
        let expected = LinkListState(links: [])
        XCTAssertEqual(output, expected)
    }
    
    func test_linkListReducer_withInitialEmptyState_andGoToListAction() {
        let input: LinkListState? = nil
        let output = linkListReducer(action: GoToLinkList(list: ["https://catbox.moe/dhdhhd.jpg",
                                                                 "https://catbox.moe/dhdhhd.jpg"]),
                                     state: input)
        let expected = LinkListState(links: ["https://catbox.moe/dhdhhd.jpg",
                                             "https://catbox.moe/dhdhhd.jpg"])
        XCTAssertEqual(output, expected)
    }
}
