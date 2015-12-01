## Binary Search Swift Extension
[![Build Status](https://travis-ci.org/giannif/BinarySearch.svg)](https://travis-ci.org/giannif/BinarySearch)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

Perform a [binary search][wiki] on [Collections][] (e.g. [Array][], [Dictionary][], [Set][]), with a few powerful options such as finding the first or last index in the collection, matching an optional [predicate](#predicate), and the ability to [extract](#extract) values from a collection to avoid having to prepare that collection for a binary search. 

### Methods
- [binarySearch](#binarySearch) - Find the index of the first element that passes the truth test (predicate). The default predicate is `==`.
- [binarySearchFirst](#binarySearchFirst) - Find the index of the first element in the collection that matches the predicate.
- [binarySearchLast](#binarySearchLast) - Find the index of the last element in the collection that matches the predicate.
- [binarySearchRange](#binarySearchRange) - Find the startIndex and endIndex of elements that match the predicate. 

### Arguments
- `find` _required_ - The value you're looking for
- `predicate` _optional_ - A truth test, e.g. `$0 <= $1`, `$0.hasPrefix($1)`, where `$0` is the value of `find` and `$1` is the current element value. See [more](#predicate).
- `extract` _optional_ - The value to compare, e.g. `$0.someVal`, where `someVal` is the same type as the argument for 
`find`. See [more](#extract).

**Important**
> Running binary search requires sorted data. 

**Important**
> Duplicate values are unsupported.

### Performance Benefit
Binary Search runs in O(log n), as opposed to linear search which runs in O(n). 
Meaning, if you use linear search, in the worst case scenario, the number of steps to find your value will equal the number of elements.
For binary search, this number is [dramatically lower][wikiPerformance]. 

All binary search methods in this extension return an `Index`, or a `Range<Index>` for `binarySearchRange`.

<a name="binarySearch"></a>
#### binarySearch

_In all examples below, assume the tests pass._ The documation code has <a href="BinarySearchTests/DocumentationTests.swift">tests</a>.

Find an item that is equal to the first argument. 

```Swift
let sortedInts = [0,1,2,3,4,5,6,7,8,9,10]
guard let intIndex = sortedInts.binarySearch(6) else {
  XCTFail("Failed to find Int 6")
  return
}
XCTAssertEqual(intIndex, 6)
// In this contrived example, our values are the same as the indices.
XCTAssertEqual(sortedInts[intIndex], 6) 
```

```Swift
let fruitsArray = ["apples", "bananas", "oranges"]
guard let fruitIndex = fruitsArray.binarySearch("bananas") else {
  XCTFail("Failed to find 'bananas'")
  return
}
XCTAssertEqual(fruitIndex, 1)
XCTAssertEqual(fruitsArray[fruitIndex], "bananas")

let kiwiIndex = fruitsArray.binarySearch("kiwi")
XCTAssertNil(kiwiIndex) // If the search fails the result is nil
```
<a name="Predicate"></a>
#### Predicate
An optional argument to evaluate truthfulness. The default is `$0 == $1`, where `$0` is the value of `find` and `$1` is the current element value.


```Swift
let fruitsArray = ["apples", "bananas", "oranges"]
guard let index = fruitsArray.binarySearch("bana", predicate:{$0.hasPrefix($1)}) else {
  XCTFail("Failed to find element that begins with 'bana'")
  return
}
XCTAssertEqual(index, 1)
XCTAssertEqual(fruitsArray[index], "bananas")
```

<a name="extract"></a>
#### Extract
An optional argument to extract a value. The value must match the type you're searching for, 
and the array must be sorted on the property that you're extracting.

The default is `Generator.Element -> T = {(el) -> T in return el as! T}`

```Swift
struct Fruit {
  let name:String
}
// An Array of Fruits
let fruits = [
  Fruit(name:"apple"),
  Fruit(name:"banana"),
  Fruit(name:"orange")
]
guard let index = fruits.binarySearch("banana", extract:{$0.name}) else {
  XCTFail("Failed to find a dictionary with a name 'bananas'")
  return
}
XCTAssertEqual(index, 1)
XCTAssertEqual(fruits[index].name, "banana")
```

<a name="binarySearchFirst"></a>
#### binarySearchFirst

Find the value with the lowest index that meets the predicate.

```Swift
let sortedArray = [0,5,15,75,100]
guard let indexGreaterThanOrEqual = sortedArray.binarySearchFirst(10, predicate: {$0 >= $1}) else {
  XCTFail("Failed to find an index greater than or equal to 10")
  return
}
XCTAssertEqual(indexGreaterThanOrEqual, 2)
XCTAssertEqual(sortedArray[indexGreaterThanOrEqual], 15)

guard let indexLessThanOrEqual = sortedArray.binarySearchFirst(10, predicate: {$0 <= $1}) else {
  XCTFail("Failed to find an index less than or equal to 10")
  return
}
XCTAssertEqual(indexLessThanOrEqual, 0)
XCTAssertEqual(sortedArray[indexLessThanOrEqual], 0)
```
<a name="binarySearchLast"></a>
#### binarySearchLast

Find the value with the highest index that meets the predicate.
```Swift
let sortedArray = [0,5,15,75,100]
guard let indexGreaterThanOrEqual = sortedArray.binarySearchLast(10, predicate: {$0 >= $1}) else {
  XCTFail("Failed to find an index greater than or equal to 10")
  return
}
XCTAssertEqual(indexGreaterThanOrEqual, 4)
XCTAssertEqual(sortedArray[indexGreaterThanOrEqual], 100)

guard let indexLessThanOrEqual = sortedArray.binarySearchLast(10, predicate: {$0 <= $1}) else {
  XCTFail("Failed to find an index less than or equal to 10")
  return
}
XCTAssertEqual(indexLessThanOrEqual, 1)
XCTAssertEqual(sortedArray[indexLessThanOrEqual], 5)
```

<a name="binarySearchRange"></a>
#### binarySearchRange

A convenience method that wraps [binarySearchFirst](#binarySearchFirst) and [binarySearchLast](#binarySearchLast)

```Swift
let sortedArray = [0,5,15,75,100]
guard let range = sortedArray.binarySearchRange(10, predicate:{$0 >= $1}) else {
  XCTFail("Failed to find a range of Ints greater than or equal to 10")
  return
}
XCTAssertEqual(range.startIndex, 2)
XCTAssertEqual(sortedArray[range.startIndex], 15)
XCTAssertEqual(range.endIndex, 4)
XCTAssertEqual(sortedArray[range.endIndex], 100)
```

If you need to have a different predicate for the start and end, just use the `binarySearchFirst` and `binarySearchLast` methods:

```Swift 
let sortedArray = [0,5,15,75,100,150]
guard let startIndex = sortedArray.binarySearchFirst(10, predicate:{$0 >= $1}),
  endIndex = sortedArray.binarySearchLast(100, predicate:{$0 <= $1})
  else {
    XCTFail("Failed to find a range of Ints greater than or equal to 10 and less than or equal to 100")
    return
}
// Find the range of values that's greater than or equal to 10
XCTAssertEqual(startIndex, 2)
XCTAssertEqual(sortedArray[startIndex], 15)
XCTAssertEqual(endIndex, 4)
XCTAssertEqual(sortedArray[endIndex], 100)
```

#### Installation 

Copy the <a href="BinarySearch/BinarySearch.swift">BinarySearch.swift</a> file into your project, or use [Carthage][].

# To Do #
* [ ] What can the predicate contain?
* [ ] Support for duplicate values, or throw an error when they're encountered
* [ ] Clean up tests. Write more tests.
* [x] Carthage support
* [x] Installation instructions
* [x] Run tests on Travis CI

[wiki]: https://en.wikipedia.org/wiki/Binary_search_algorithm
[wikiPerformance]: https://en.wikipedia.org/wiki/Binary_search_algorithm#Performance "Binary Search Performance"
[Collections]: https://developer.apple.com/library/watchos/documentation/Swift/Reference/Swift_CollectionType_Protocol/index.html
[Array]: https://developer.apple.com/library/prerelease/ios/documentation/Swift/Reference/Swift_Array_Structure/
[Set]: https://developer.apple.com/library/prerelease/ios/documentation/Swift/Reference/Swift_Set_Structure/
[Dictionary]: https://developer.apple.com/library/prerelease/ios/documentation/Swift/Reference/Swift_Dictionary_Structure/
[Carthage]: https://github.com/Carthage/Carthage

