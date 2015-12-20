//
//  BinarySearch.swift
//  BinarySearch
//
//  Created by Gianni Ferullo on 11/16/15.
//  Copyright © 2015 Gianni Ferullo. All rights reserved.
//

import Foundation

public extension CollectionType where Index: RandomAccessIndexType  {
  
  func binarySearch<T:Comparable>(find:T,
    extract: Generator.Element -> T = {(el) -> T in return el as! T},
    predicate: (T,T) -> Bool = {(val1, val2) -> Bool in return val1 == val2}
    )-> Index? {
      var left = startIndex
      var right = endIndex - 1
      while (left <= right) {
        let mid = left.advancedBy(left.distanceTo(right) / 2)
        let currentValue:T = extract(self[mid])
        if left == right {
          return predicate(currentValue, find) ? left : nil
        }
        if predicate(currentValue, find) {
          return mid
        }else if currentValue == find {
          return checkLeft(find, mid, extract, predicate) ?? checkRight(find, mid, extract, predicate)
        }else if currentValue < find {
          left = mid.advancedBy(1)
        }else if currentValue > find {
          right = mid.advancedBy(-1)
        }else {
          return nil
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
        if left == right {
          return predicate(currentValue, find) ? left : nil
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
        }else {
          return nil
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
        if left == right {
          return predicate(currentValue, find) ? left : nil
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
        }else {
          return nil
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
  
  func binarySearchInsertionIndexFor<T:Comparable>(find:T,
    extract: Generator.Element -> T = {(el) -> T in return el as! T}
    ) -> Index? {
      if let foundIndex = binarySearchLast(find, predicate:{$0 <= $1}, extract:extract) {
        let val = extract(self[foundIndex])
        if val != find {
          return foundIndex.advancedBy(1)
        }else{
          return nil
        }
      }else if let first = self.first {
        return find < extract(first) ? startIndex : endIndex
      }else {
        return startIndex
      }
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