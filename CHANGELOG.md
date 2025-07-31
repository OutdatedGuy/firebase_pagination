## 4.2.0

- feat: updated Firebase dependencies to latest versions (`cloud_firestore: ^6.0.0` and `firebase_database: ^12.0.0`)
- chore: updated example template to Flutter 3.32

## 4.1.0

- feat: add substring filter for specific fields in pagination. Thanks [@delwar36](https://github.com/delwar36) for [#62](https://github.com/OutdatedGuy/firebase_pagination/pull/62)
- chore: updated example to Flutter 3.27

## 4.0.1

- refactor: lowered sdk constraints to support dart 2.17 and above

## 4.0.0

### BREAKING CHANGES

- `itemBuilder` will now send the entire document snapshot array instead of a single document snapshot. Thanks [@opxdelwin](https://github.com/opxdelwin) for [#48](https://github.com/OutdatedGuy/firebase_pagination/pull/48)

### Features

- feat: added `PageView` support in pagination display types
- feat: supports `cloud_firestore: ^5.0.0` and `firebase_database: ^11.0.0` versions

### Chore

- chore: updated example to latest version

## 3.1.0

- feat: update package and example template to latest
- feat: Descending Pagination for realtime Database. Thanks [@CodeWithBishal](https://github.com/CodeWithBishal) for [#34](https://github.com/OutdatedGuy/firebase_pagination/pull/34)
- docs: updated example and readme for new feature

## 3.0.1

- fix: docs not loading after the first scroll

## 3.0.0

- CHORE: Updated to latest version of firebase packages

## 2.0.0

- **BREAKING CHANGE:** added required field `orderBy` for realtime live listener.

- FIX: realtime db pagination shows data without live listener
- FIX: more data not loaded when view not scrollable
- FIX: firestore newly added data not shown for non server-timestamp queries
- FIX: realtime db typecasting for android
- DOCS: added example code for both paginations

## 1.1.3

- FIX: `endBefore` value for firebase database not valid

## 1.1.2

- FIX: `startAt` value for firebase database not valid

## 1.1.1+2

- FIX: closed issues link not correct (readme)

## 1.1.1+1

- DOCS: readme changing pr count to closed issues count
- DOCS: changing readme links to relative blob files

## 1.1.1

- FIX: Demo video not visible in readme

## 1.1.0

- FEAT: added optional property `controller`

## 1.0.0

- Initial Public Release
- Supports `Firestore` and `Realtime Database` pagination.
