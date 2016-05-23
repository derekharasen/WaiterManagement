//
//  Constants.swift
//  StaffManagement
//
//  Created by Karlo Pagtakhan on 05/22/2016.
//  Copyright © 2016 Derek Harasen. All rights reserved.
//

import Foundation


struct Constants {
  struct Date {
    static let timeFormat = "hh:mma"
    static let time = "08:00AM"
  }
  struct Alert{
    struct Button {
      static let ok = "Ok"
      static let cancel = "Cancel"
    }
    struct Title {
      static let error = "Error"
    }
    struct Message {
      static let shiftSaveError = "Shift cannot be saved"
      static let shiftDeleteError = "Shift cannot be deleted"
      static let shiftNoName = "Enter Shift name"
    }
  }
  struct Form {
    struct Shift {
      static let start = "Start"
      static let end = "End"
    }
  }
}