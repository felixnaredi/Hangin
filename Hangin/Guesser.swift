// Guesser.swift
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

import Foundation

func isLetter(_ character: Character) -> Bool {
  return CharacterSet.letters.contains(character.unicodeScalars.first!)
}

func lowercase(_ character: Character) -> Character? {
  let newCharacter = String(character).lowercased().first!
  if !CharacterSet.lowercaseLetters.contains(newCharacter.unicodeScalars.first!) { return nil }
  return newCharacter
}

func uppercase(_ character: Character) -> Character? {
  let newCharacter = String(character).uppercased().first!
  if !CharacterSet.uppercaseLetters.contains(newCharacter.unicodeScalars.first!) { return nil }
  return newCharacter
}

struct Guesser {
  let word: String

  init(word: String) {
    self.word = word.lowercased()
  }

  func wordContains(_ character: Character) -> Bool? {
    guard let character = lowercase(character) else { return nil }
    return word.contains(character)
  }

  var hiddenWord: [Character?] { return Array(repeating: nil, count: word.count) }

  func hiddenWord<Characters: Sequence>(with characters: Characters) -> [Character?]
  where Characters.Element == Character {
    return
      word.indices.map({ characters.map({ lowercase($0) }).contains(word[$0]) ? word[$0] : nil })
  }

  func captilizedHiddenWord<Characters: Sequence>(with characters: Characters) -> [Character?]
  where Characters.Element == Character {
    return
      word.indices.map({
      characters.map({ lowercase($0) }).contains(word[$0]) ? word.capitalized[$0] : nil
    })
  }

  func completed<Characters: Sequence>(with characters: Characters) -> Bool
  where Characters.Element == Character {
    return word.allSatisfy({ characters.contains($0) })
  }

  func isInvalid(_ character: Character) -> Bool {
    return !isLetter(character)
  }
}
