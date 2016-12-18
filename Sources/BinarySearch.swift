//
//  BinarySearch.swift
//  BinarySearch
//
//  Created by Gianni Ferullo on 11/16/15.
//  Copyright © 2015 Gianni Ferullo. All rights reserved.
//

import Foundation

public extension Collection where Index: Strideable  {
  
  func binarySearch<T:Comparable>(_ find:T,
    extract: (Iterator.Element) -> T = {(el) -> T in return el as! T},
    predicate: (T,T) -> Bool = {(val1, val2) -> Bool in return val1 == val2}
    )-> Index? {
      var left = startIndex
      var right = endIndex - 1
      while (left <= right) {
        let mid = index(left, offsetBy: distance(from: left, to: right) / 2)
        let currentValue:T = extract(self[mid])
        if left == right {
          return predicate(currentValue, find) ? left : nil
        }
        if predicate(currentValue, find) {
          return mid
        }else if currentValue == find {
          return checkLeft(find, mid, extract, predicate) ?? checkRight(find, mid, extract, predicate)
        }else if currentValue < find {
          left = index(mid, offsetBy: 1)
        }else if currentValue > find {
          right = index(mid, offsetBy: -1)
        }else {
          return nil
        }
      }
      return nil
  }
  
  func binarySearchFirst<T:Comparable>(_ find:T,
    extract: (Iterator.Element) -> T = {(el) -> T in return el as! T},
    predicate: (T,T) -> Bool = {(val1, val2) -> Bool in return val1 == val2}
    )-> Index? {
      var left = startIndex
      var right = endIndex - 1
      while (left <= right) {
        let mid = index(left, offsetBy: distance(from: left, to: right) / 2)
        let currentValue:T = extract(self[mid])
        if left == right {
          return predicate(currentValue, find) ? left : nil
        }
        if predicate(currentValue, find) {
          if checkLeft(find, mid, extract, predicate) == nil {
            return mid
          }
          right = index(mid, offsetBy: -1)
        }else if currentValue == find {
          return checkLeft(find, mid, extract, predicate) ?? checkRight(find, mid, extract, predicate)
        }else if currentValue < find {
          left = index(mid, offsetBy: 1)
        }else if currentValue > find {
          right = index(mid, offsetBy: -1)
        }else {
          return nil
        }
      }
      return nil
  }
  
  func binarySearchLast<T:Comparable>(_ find:T,
    extract: (Iterator.Element) -> T = {(el) -> T in return el as! T},
    predicate: (T,T) -> Bool = {(val1, val2) -> Bool in return val1 == val2}
    )-> Index? {
      var left = startIndex
      var right = endIndex - 1
      while (left <= right) {
        let mid = index(left, offsetBy: distance(from: left, to: right) / 2)
        let currentValue:T = extract(self[mid])
        if left == right {
          return predicate(currentValue, find) ? left : nil
        }
        if predicate(currentValue, find) {
          if checkRight(find, mid, extract, predicate) == nil {
            return mid
          }
          left = index(mid, offsetBy: 1)
        }else if currentValue == find {
          return checkLeft(find, mid, extract, predicate) ?? checkRight(find, mid, extract, predicate)
        }else if currentValue < find {
          left = index(mid, offsetBy: 1)
        }else if currentValue > find {
          right = index(mid, offsetBy: -1)
        }else {
          return nil
        }
      }
      return nil
  }
  
  func binarySearchRange<T:Comparable>(_ find:T,
    extract: (Iterator.Element) -> T = {(el) -> T in return el as! T},
    predicate: (T,T) -> Bool = {(val1, val2) -> Bool in return val1 == val2}
    )-> Range<Index>? {
      if let first = binarySearchFirst(find, extract: extract, predicate: predicate),
        let last = binarySearchLast(find, extract: extract, predicate: predicate){
        return Range<Index>(uncheckedBounds: (lower: first, upper: last))
      }
      return nil
  }
  
  func binarySearchInsertionIndexFor<T:Comparable>(find:T,
    extract: (Iterator.Element) -> T = {(el) -> T in return el as! T}
    ) -> Index? {
      if let foundIndex = binarySearchLast(find, extract:extract, predicate:{$0 <= $1}) {
        let val = extract(self[foundIndex])
        if val != find {
          return index(foundIndex, offsetBy: 1)
        }else{
          return nil
        }
      }else if let first = self.first {
        return find < extract(first) ? startIndex : endIndex
      }else {
        return startIndex
      }
  }
  
  private func checkRight<T:Comparable>(_ find:T, _ mid:Index, _ extract: (Iterator.Element) -> T, _ predicate: (T,T) -> Bool) -> Index?{
    if distance(from: mid, to: endIndex) > 0 {
      let i = index(mid, offsetBy: 1)
      if predicate(extract(self[i]), find) {
        return i
      }
    }
    return nil
  }
  
  private func checkLeft<T:Comparable>(_ find:T, _ mid:Index, _ extract: (Iterator.Element) -> T, _ predicate: (T,T) -> Bool) -> Index?{
    if distance(from: startIndex, to: mid) > 0 {
      let i = index(mid, offsetBy: -1)
      if predicate(extract(self[i]), find) {
        return i
      }
    }
    return nil
  }
}
