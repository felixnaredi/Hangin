// HiddenWordTextField.swift
//
// Copyright © 2019, Felix Naredi
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// 1. Redistributions of source code must retain the above copyright notice, this
//    list of conditions and the following disclaimer.
// 2. Redistributions in binary form must reproduce the above copyright notice,
//    this list of conditions and the following disclaimer in the documentation
//    and/or other materials provided with the distribution.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
// ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// The views and conclusions contained in the software and documentation are those
// of the authors and should not be interpreted as representing official policies,
// either expressed or implied, of the Hangin project.
//

import Cocoa

extension NSTextField {
  func withMutableAttributedString(_ transform: (NSMutableAttributedString) -> Void) {
    let mutableAttributedString = NSMutableAttributedString(attributedString: attributedStringValue)
    transform(mutableAttributedString)
    attributedStringValue = mutableAttributedString
  }
}

class HiddenWordTextField: NSTextField {
  private static let nilCharacter: Character = "_"

  override var stringValue: String {
    didSet {
      withMutableAttributedString({
        $0.addAttribute(.kern, value: 16, range: NSRange(0..<$0.length))
      })
    }
  }

  var hiddenWord: [Character?] {
    get { return stringValue.map { $0 == HiddenWordTextField.nilCharacter ? nil : $0 } }
    set { stringValue = String(newValue.map({ $0 ?? HiddenWordTextField.nilCharacter })) }
  }
}
