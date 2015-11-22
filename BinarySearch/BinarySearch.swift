//
//  BinarySearch.swift
//  BinarySearch
//
//  Created by Gianni Ferullo on 11/16/15.
//  Copyright © 2015 Gianni Ferullo. All rights reserved.
//

import Foundation

extension CollectionType where Index: RandomAccessIndexType  {
  
  func binarySearch<T:Comparable>(find:T,
    extract: Generator.Element -> T = {(el) -> T in return el as! T},
    predicate: (T,T) -> Bool = {(val1, val2) -> Bool in return val1 == val2}
    )-> Index? {
      var left = startIndex
      var right = endIndex - 1
      while (left <= right) {
        let mid = left.advancedBy(left.distanceTo(right) / 2)
        let currentValue:T = extract(self[mid])
        if predicate(currentValue, find) {
          return mid
        }else if currentValue == find {
          return checkLeft(find, mid, extract, predicate) ?? checkRight(find, mid, extract, predicate)
        }else if currentValue < find {
          left = mid.advancedBy(1)
        }else if currentValue > find {
          right = mid.advancedBy(-1)
        }
      }
      return nil
  }
  
  func binarySearchFirst<T:Comparable>(find:T,
    extract: Generator.Element -> T = {(el) -> T in return el as! T},
    predicate: (T,T) -> Bool = {(val1, val2) -> Bool in return val1 == val2}
    )-> Index? {
      var left = startIndex
      var right = endIndex - 1
      while (left <= right) {
        let mid = left.advancedBy(left.distanceTo(right) / 2)
        let currentValue:T = extract(self[mid])
        if left == right && predicate(currentValue, find) {
          return left
        }
        if predicate(currentValue, find) {
          if checkLeft(find, mid, extract, predicate) == nil {
            return mid
          }
          right = mid.advancedBy(-1)
        }else if currentValue == find {
          return checkLeft(find, mid, extract, predicate) ?? checkRight(find, mid, extract, predicate)
        }else if currentValue < find {
          left = mid.advancedBy(1)
        }else if currentValue > find {
          right = mid.advancedBy(-1)
        }
      }
      return nil
  }
  
  func binarySearchLast<T:Comparable>(find:T,
    extract: Generator.Element -> T = {(el) -> T in return el as! T},
    predicate: (T,T) -> Bool = {(val1, val2) -> Bool in return val1 == val2}
    )-> Index? {
      var left = startIndex
      var right = endIndex - 1
      while (left <= right) {
        let mid = left.advancedBy(left.distanceTo(right) / 2)
        let currentValue:T = extract(self[mid])
        if left == right && predicate(currentValue, find) {
          return left
        }
        if predicate(currentValue, find) {
          if checkRight(find, mid, extract, predicate) == nil {
            return mid
          }
          left = mid.advancedBy(1)
        }else if currentValue == find {
          return checkLeft(find, mid, extract, predicate) ?? checkRight(find, mid, extract, predicate)
        }else if currentValue < find {
          left = mid.advancedBy(1)
        }else if currentValue > find {
          right = mid.advancedBy(-1)
        }
      }
      return nil
  }
  
  func binarySearchRange<T:Comparable>(find:T,
    extract: Generator.Element -> T = {(el) -> T in return el as! T},
    predicate: (T,T) -> Bool = {(val1, val2) -> Bool in return val1 == val2}
    )-> Range<Index>? {
      if let first = binarySearchFirst(find, extract: extract, predicate: predicate),
        last = binarySearchLast(find, extract: extract, predicate: predicate){
          return Range<Index>(start: first, end: last)
      }
      return nil
  }
  
  private func checkRight<T:Comparable>(find:T, _ mid:Index, _ extract: Generator.Element -> T, _ predicate: (T,T) -> Bool) -> Index?{
    if mid.distanceTo(endIndex) > 0 {
      let index = mid.advancedBy(1)
      if predicate(extract(self[index]), find) {
        return index
      }
    }
    return nil
  }
  
  private func checkLeft<T:Comparable>(find:T, _ mid:Index, _ extract: Generator.Element -> T, _ predicate: (T,T) -> Bool) -> Index?{
    if startIndex.distanceTo(mid) > 0 {
      let index = mid.advancedBy(-1)
      if predicate(extract(self[index]), find) {
        return index
      }
    }
    return nil
  }
}