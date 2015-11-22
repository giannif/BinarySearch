//
//  BinarySearchExtractTest.swift
//  BinarySearch
//
//  Created by Gianni Ferullo on 11/20/15.
//  Copyright © 2015 Gianni Ferullo. All rights reserved.
//



import XCTest
@testable import BinarySearch

class DocumentationTests: XCTestCase {
  
  func test() {
    let sortedInts = [0,1,2,3,4,5,6,7,8,9,10]
    guard let intIndex = sortedInts.binarySearch(6) else {
      XCTFail("Failed to find Int 6")
      return
    }
    XCTAssertEqual(intIndex, 6)
    XCTAssertEqual(sortedInts[intIndex], 6) // Our values are the same as the indices in this example.
    
    let fruitsArray = ["apples", "bananas", "oranges"]
    guard let fruitIndex = fruitsArray.binarySearch("bananas") else {
      XCTFail("Failed to find 'bananas'")
      return
    }
    XCTAssertEqual(fruitIndex, 1)
    XCTAssertEqual(fruitsArray[fruitIndex], "bananas")
    
    let kiwiIndex = fruitsArray.binarySearch("kiwi")
    kiwiIndex // nil
    XCTAssertNil(kiwiIndex)
  }
  
  func testPredicate() {
    let fruitsArray = ["apples", "bananas", "oranges"]
    guard let index = fruitsArray.binarySearch("bana", predicate:{$0.hasPrefix($1)}) else {
      XCTFail("Failed to find element that begins with 'bana'")
      return
    }
    XCTAssertEqual(index, 1)
    XCTAssertEqual(fruitsArray[index], "bananas")
  }
  
  func testExtract() {
    struct Fruit {
      let name:String
    }
    // An Array of Fruits
    let dict = [
      Fruit(name:"apple"),
      Fruit(name:"banana"),
      Fruit(name:"orange")
    ]
    guard let index = dict.binarySearch("banana", extract:{$0.name}) else {
      XCTFail("Failed to find a dictionary with a testValue of 'bananas'")
      return
    }
    XCTAssertEqual(index, 1)
    XCTAssertEqual(dict[index].name, "banana")
  }
  
  func testFullExample() {
    
    struct Album {
      let name:String
      let date:NSTimeInterval
      init(_ name:String, _ date:String){
        self.name = name
        self.date = Album.getDate(date)
      }
      static func getDate(date: String) -> NSTimeInterval{
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.dateFromString(date)!.timeIntervalSince1970
      }
    }
    
    // An Array of albums, sorted by date
    let stonesAlbums = [
      Album("Beggars Banquet", "1968-12-06"),
      Album("Let It Bleed", "1969-12-05"),
      Album("Sticky Fingers", "1971-04-23"),
      Album("Exile on Main St.", "1972-05-12"),
      Album("Some Girls", "1978-06-9"),
      Album("Emotional Rescue", "1980-06-20"),
      Album("Tattoo You", "1981-08-24"),
      Album("Undercover", "1983-11-07")
    ]
    
    guard let firstStonesAlbumSeventies = stonesAlbums.binarySearchFirst(Album.getDate("1970-01-01"),
      // We want to find the first value greater than Jan 1, 1970
      predicate: {$0 >= $1},
      // Extract the date value to test with the predicate above
      extract: {$0.date}) else {
        XCTFail("Failed to find a Rolling Stones album after 1970")
        return
    }
    XCTAssertEqual(firstStonesAlbumSeventies, 2)
    XCTAssertEqual(stonesAlbums[firstStonesAlbumSeventies].name, "Sticky Fingers")
    guard let lastStonesAlbumSixties = stonesAlbums.binarySearchLast(Album.getDate("1970-01-01"),
      // We want to find the first value greater than Jan 1, 1970
      predicate: {$0 <= $1},
      // Extract the date value to test with the predicate above
      extract: {$0.date}) else {
        XCTFail("Failed to find a Rolling Stones album after 1970")
        return
    }
    XCTAssertEqual(lastStonesAlbumSixties, 1)
    XCTAssertEqual(stonesAlbums[lastStonesAlbumSixties].name, "Let It Bleed")
    guard let albumSixties = stonesAlbums.binarySearchRange(Album.getDate("1970-01-01"),
      // We want to find the first value greater than Jan 1, 1970
      predicate: {$0 >= $1 && $0 < Album.getDate("1978-01-01")},
      // Extract the date value to test with the predicate above
      extract: {$0.date}) else {
        
        XCTFail("Failed to find a Rolling Stones album after 1970")
        return
    }
    XCTAssertEqual(albumSixties.startIndex, 2)
    XCTAssertEqual(albumSixties.endIndex, 3)
  }
  
  func testFirst() {
    let sortedArray = [0,5,15,75,100]
    func compare(val:Int, val2:Int) -> Bool {
      return val > 10
    }
    guard let indexGreaterThanOrEqual = sortedArray.binarySearchFirst(10, predicate: compare) else {
      XCTFail("Failed to find an index greater than or equal to 10")
      return
    }
    // Find the first value that's greater than or equal to 10
    XCTAssertEqual(indexGreaterThanOrEqual, 2)
    XCTAssertEqual(sortedArray[indexGreaterThanOrEqual], 15)
    
    guard let indexLessThanOrEqual = sortedArray.binarySearchFirst(10, predicate: {$0 <= $1}) else {
      XCTFail("Failed to find an index less than or equal to 10")
      return
    }
    XCTAssertEqual(indexLessThanOrEqual, 0)
    XCTAssertEqual(sortedArray[indexLessThanOrEqual], 0)
  }
  
  func testLast() {
    let sortedArray = [0,5,15,75,100]
    guard let indexGreaterThanOrEqual = sortedArray.binarySearchLast(10, predicate: {$0 >= $1}) else {
      XCTFail("Failed to find an index greater than or equal to 10")
      return
    }
    // Find the first value that's greater than or equal to 10
    XCTAssertEqual(indexGreaterThanOrEqual, 4)
    XCTAssertEqual(sortedArray[indexGreaterThanOrEqual], 100)
    
    guard let indexLessThanOrEqual = sortedArray.binarySearchLast(10, predicate: {$0 <= $1}) else {
      XCTFail("Failed to find an index less than or equal to 10")
      return
    }
    XCTAssertEqual(indexLessThanOrEqual, 1)
    XCTAssertEqual(sortedArray[indexLessThanOrEqual], 5)
  }
  
  func testRange() {
    let sortedArray = [0,5,15,75,100]
    guard let range = sortedArray.binarySearchRange(10, predicate:{$0 >= $1}) else {
      XCTFail("Failed to find a range of Ints greater than or equal to 10")
      return
    }
    // Find the range of values that's greater than or equal to 10
    XCTAssertEqual(range.startIndex, 2)
    XCTAssertEqual(sortedArray[range.startIndex], 15)
    XCTAssertEqual(range.endIndex, 4)
    XCTAssertEqual(sortedArray[range.endIndex], 100)
    
  }
  
  func testManualRange() {
    let sortedArray = [0,5,15,75,100,150]
    guard let startIndex = sortedArray.binarySearchFirst(10, predicate:{$0 >= $1}),
      endIndex = sortedArray.binarySearchLast(100, predicate:{$0 <= $1})
      else {
        XCTFail("Failed to find a range of Ints greater than or equal to 10")
        return
    }
    // Find the range of values that's greater than or equal to 10
    XCTAssertEqual(startIndex, 2)
    XCTAssertEqual(sortedArray[startIndex], 15)
    XCTAssertEqual(endIndex, 4)
    XCTAssertEqual(sortedArray[endIndex], 100)
  }
}
