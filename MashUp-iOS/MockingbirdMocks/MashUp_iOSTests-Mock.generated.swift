//
//  MashUp_iOSTests-Mock.generated.swift
//  MashUp_iOS
//
//  Generated by Mockingbird v0.20.0.
//  DO NOT EDIT
//

@testable import MashUp_iOS
@testable import Mockingbird
import AVFoundation
import Foundation
import Moya
import ReactorKit
import RxCocoa
import RxMoya
import RxRelay
import RxSwift
import SnapKit
import Swift
import UIKit

private let mkbGenericStaticMockContext = Mockingbird.GenericStaticMockContext()

// MARK: - Mocked AttendanceService
public final class AttendanceServiceMock: MashUp_iOS.AttendanceService, Mockingbird.Mock {
  typealias MockingbirdSupertype = MashUp_iOS.AttendanceService
  public static let mockingbirdContext = Mockingbird.Context()
  public let mockingbirdContext = Mockingbird.Context(["generator_version": "0.20.0", "module_name": "MashUp_iOS"])

  fileprivate init(sourceLocation: Mockingbird.SourceLocation) {
    self.mockingbirdContext.sourceLocation = sourceLocation
    AttendanceServiceMock.mockingbirdContext.sourceLocation = sourceLocation
  }

  // MARK: Mocked `attend`(withCode `code`: MashUp_iOS.Code)
  public func `attend`(withCode `code`: MashUp_iOS.Code) -> Observable<Bool> {
    return self.mockingbirdContext.mocking.didInvoke(Mockingbird.SwiftInvocation(selectorName: "`attend`(withCode `code`: MashUp_iOS.Code) -> Observable<Bool>", selectorType: Mockingbird.SelectorType.method, arguments: [Mockingbird.ArgumentMatcher(`code`)], returnType: Swift.ObjectIdentifier((Observable<Bool>).self))) {
      self.mockingbirdContext.recordInvocation($0)
      let mkbImpl = self.mockingbirdContext.stubbing.implementation(for: $0)
      if let mkbImpl = mkbImpl as? (MashUp_iOS.Code) -> Observable<Bool> { return mkbImpl(`code`) }
      if let mkbImpl = mkbImpl as? () -> Observable<Bool> { return mkbImpl() }
      for mkbTargetBox in self.mockingbirdContext.proxy.targets(for: $0) {
        switch mkbTargetBox.target {
        case .super:
          break
        case .object(let mkbObject):
          guard var mkbObject = mkbObject as? MockingbirdSupertype else { break }
          let mkbValue: Observable<Bool> = mkbObject.`attend`(withCode: `code`)
          self.mockingbirdContext.proxy.updateTarget(&mkbObject, in: mkbTargetBox)
          return mkbValue
        }
      }
      if let mkbValue = self.mockingbirdContext.stubbing.defaultValueProvider.value.provideValue(for: (Observable<Bool>).self) { return mkbValue }
      self.mockingbirdContext.stubbing.failTest(for: $0, at: self.mockingbirdContext.sourceLocation)
    }
  }

  public func `attend`(withCode `code`: @autoclosure () -> MashUp_iOS.Code) -> Mockingbird.Mockable<Mockingbird.FunctionDeclaration, (MashUp_iOS.Code) -> Observable<Bool>, Observable<Bool>> {
    return Mockingbird.Mockable<Mockingbird.FunctionDeclaration, (MashUp_iOS.Code) -> Observable<Bool>, Observable<Bool>>(context: self.mockingbirdContext, invocation: Mockingbird.SwiftInvocation(selectorName: "`attend`(withCode `code`: MashUp_iOS.Code) -> Observable<Bool>", selectorType: Mockingbird.SelectorType.method, arguments: [Mockingbird.resolve(`code`)], returnType: Swift.ObjectIdentifier((Observable<Bool>).self)))
  }
}

/// Returns a concrete mock of `AttendanceService`.
public func mock(_ type: MashUp_iOS.AttendanceService.Protocol, file: StaticString = #file, line: UInt = #line) -> AttendanceServiceMock {
  return AttendanceServiceMock(sourceLocation: Mockingbird.SourceLocation(file, line))
}

// MARK: - Mocked QRReaderService
public final class QRReaderServiceMock: MashUp_iOS.QRReaderService, Mockingbird.Mock {
  typealias MockingbirdSupertype = MashUp_iOS.QRReaderService
  public static let mockingbirdContext = Mockingbird.Context()
  public let mockingbirdContext = Mockingbird.Context(["generator_version": "0.20.0", "module_name": "MashUp_iOS"])

  // MARK: Mocked captureSession
  public var `captureSession`: AVCaptureSession {
    get {
      return self.mockingbirdContext.mocking.didInvoke(Mockingbird.SwiftInvocation(selectorName: "captureSession.getter", setterSelectorName: "captureSession.setter", selectorType: Mockingbird.SelectorType.getter, arguments: [], returnType: Swift.ObjectIdentifier((AVCaptureSession).self))) {
        self.mockingbirdContext.recordInvocation($0)
        let mkbImpl = self.mockingbirdContext.stubbing.implementation(for: $0)
        if let mkbImpl = mkbImpl as? () -> AVCaptureSession { return mkbImpl() }
        if let mkbImpl = mkbImpl as? () -> Any { return Mockingbird.dynamicCast(mkbImpl()) as AVCaptureSession }
        for mkbTargetBox in self.mockingbirdContext.proxy.targets(for: $0) {
          switch mkbTargetBox.target {
          case .super:
            break
          case .object(let mkbObject):
            guard var mkbObject = mkbObject as? MockingbirdSupertype else { break }
            let mkbValue: AVCaptureSession = mkbObject.`captureSession`
            self.mockingbirdContext.proxy.updateTarget(&mkbObject, in: mkbTargetBox)
            return mkbValue
          }
        }
        if let mkbValue = self.mockingbirdContext.stubbing.defaultValueProvider.value.provideValue(for: (AVCaptureSession).self) { return mkbValue }
        self.mockingbirdContext.stubbing.failTest(for: $0, at: self.mockingbirdContext.sourceLocation)
      }
    }
  }

  public func getCaptureSession() -> Mockingbird.Mockable<Mockingbird.PropertyGetterDeclaration, () -> AVCaptureSession, AVCaptureSession> {
    return Mockingbird.Mockable<Mockingbird.PropertyGetterDeclaration, () -> AVCaptureSession, AVCaptureSession>(context: self.mockingbirdContext, invocation: Mockingbird.SwiftInvocation(selectorName: "captureSession.getter", setterSelectorName: "captureSession.setter", selectorType: Mockingbird.SelectorType.getter, arguments: [], returnType: Swift.ObjectIdentifier((AVCaptureSession).self)))
  }

  fileprivate init(sourceLocation: Mockingbird.SourceLocation) {
    self.mockingbirdContext.sourceLocation = sourceLocation
    QRReaderServiceMock.mockingbirdContext.sourceLocation = sourceLocation
  }

  // MARK: Mocked `scanCodeWhileSessionIsOpen`()
  public func `scanCodeWhileSessionIsOpen`() -> Observable<MashUp_iOS.Code> {
    return self.mockingbirdContext.mocking.didInvoke(Mockingbird.SwiftInvocation(selectorName: "`scanCodeWhileSessionIsOpen`() -> Observable<MashUp_iOS.Code>", selectorType: Mockingbird.SelectorType.method, arguments: [], returnType: Swift.ObjectIdentifier((Observable<MashUp_iOS.Code>).self))) {
      self.mockingbirdContext.recordInvocation($0)
      let mkbImpl = self.mockingbirdContext.stubbing.implementation(for: $0)
      if let mkbImpl = mkbImpl as? () -> Observable<MashUp_iOS.Code> { return mkbImpl() }
      for mkbTargetBox in self.mockingbirdContext.proxy.targets(for: $0) {
        switch mkbTargetBox.target {
        case .super:
          break
        case .object(let mkbObject):
          guard var mkbObject = mkbObject as? MockingbirdSupertype else { break }
          let mkbValue: Observable<MashUp_iOS.Code> = mkbObject.`scanCodeWhileSessionIsOpen`()
          self.mockingbirdContext.proxy.updateTarget(&mkbObject, in: mkbTargetBox)
          return mkbValue
        }
      }
      if let mkbValue = self.mockingbirdContext.stubbing.defaultValueProvider.value.provideValue(for: (Observable<MashUp_iOS.Code>).self) { return mkbValue }
      self.mockingbirdContext.stubbing.failTest(for: $0, at: self.mockingbirdContext.sourceLocation)
    }
  }

  public func `scanCodeWhileSessionIsOpen`() -> Mockingbird.Mockable<Mockingbird.FunctionDeclaration, () -> Observable<MashUp_iOS.Code>, Observable<MashUp_iOS.Code>> {
    return Mockingbird.Mockable<Mockingbird.FunctionDeclaration, () -> Observable<MashUp_iOS.Code>, Observable<MashUp_iOS.Code>>(context: self.mockingbirdContext, invocation: Mockingbird.SwiftInvocation(selectorName: "`scanCodeWhileSessionIsOpen`() -> Observable<MashUp_iOS.Code>", selectorType: Mockingbird.SelectorType.method, arguments: [], returnType: Swift.ObjectIdentifier((Observable<MashUp_iOS.Code>).self)))
  }
}

/// Returns a concrete mock of `QRReaderService`.
public func mock(_ type: MashUp_iOS.QRReaderService.Protocol, file: StaticString = #file, line: UInt = #line) -> QRReaderServiceMock {
  return QRReaderServiceMock(sourceLocation: Mockingbird.SourceLocation(file, line))
}
