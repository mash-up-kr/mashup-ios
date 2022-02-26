//
//  HomeReactorSpec.swift
//  MashUp-iOSTests
//
//  Created by Booung on 2022/02/26.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Mockingbird
import Nimble
import Quick
@testable import MashUp_iOS

final class HomeReactorSpec: QuickSpec {
  override func spec() {
    var sut: HomeReactor!
    beforeEach {
      sut = HomeReactor()
    }
    describe("home tab bar") {
      context("when is initial") {
        it("focus on seminar schedule screen") {
          expect { sut.currentState.currentTab }.to(equal(.seminarSchedule))
        }
      }
      context("when tapped first tab item 1") {
        beforeEach {
          sut.action.onNext(.didSelectTabItem(at: 0))
        }
        it("focus on seminar schedule screen") {
          expect { sut.currentState.currentTab }.to(equal(.seminarSchedule))
        }
      }
      context("when tapped second tab item 2") {
        beforeEach {
          sut.action.onNext(.didSelectTabItem(at: 1))
        }
        it("focus on my page screen") {
          expect { sut.currentState.currentTab }.to(equal(.myPage))
        }
      }
      context("when tapped third tab item 3") {
        beforeEach {
          sut.action.onNext(.didSelectTabItem(at: 2))
        }
        it("focus on setting screen") {
          expect { sut.currentState.currentTab }.to(equal(.setting))
        }
      }
    }
  }
}
