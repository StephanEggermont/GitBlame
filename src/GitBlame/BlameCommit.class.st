Class {
	#name : #BlameCommit,
	#superclass : #Object,
	#instVars : [
		'commitish',
		'author',
		'dateTime',
		'chunks',
		'model'
	],
	#category : #'GitBlame-Model'
}

{ #category : #accessing }
BlameCommit >> author [
	^ author
]

{ #category : #accessing }
BlameCommit >> author: anObject [
	author := anObject
]

{ #category : #'as yet unclassified' }
BlameCommit >> chunkFor: aFileReference [
	^chunks at: aFileReference ifAbsentPut: [BlameChunk new
	file: aFileReference;
	commit: self;
	model: self model;
	yourself]
]

{ #category : #accessing }
BlameCommit >> chunks [
	^ chunks
]

{ #category : #accessing }
BlameCommit >> chunks: anObject [
	chunks := anObject
]

{ #category : #'as yet unclassified' }
BlameCommit >> commitColor [
	"Some indicators that a commit requires extra attention"
	(chunks size > 50) ifTrue: [^Color red].
	((chunks sum: [:c | c lines size]) > 1000 ) ifTrue: [^Color red].
	(chunks size > 20) ifTrue: [^Color orange].
	((chunks sum: [:c | c lines size]) > 200 ) ifTrue: [^Color orange].
	(chunks size > 5) ifTrue: [^Color yellow].
	((chunks sum: [:c | c lines size]) > 50 ) ifTrue: [^Color yellow].
	^Color green	
]

{ #category : #accessing }
BlameCommit >> commitish [
	^ commitish
]

{ #category : #accessing }
BlameCommit >> commitish: anObject [
	commitish := anObject
]

{ #category : #accessing }
BlameCommit >> dateTime [
	^ dateTime
]

{ #category : #accessing }
BlameCommit >> dateTime: anObject [
	dateTime := anObject
]

{ #category : #'as yet unclassified' }
BlameCommit >> initialize [
	chunks := Dictionary new
]

{ #category : #accessing }
BlameCommit >> model [
	^ model
]

{ #category : #accessing }
BlameCommit >> model: anObject [
	model := anObject
]

{ #category : #'as yet unclassified' }
BlameCommit >> yearColor [
	| yearColors |
	yearColors := #(lightGreen green lightBlue blue lightYellow yellow lightOrange orange lightRed red white).
	^Color perform: (yearColors at: ((Date today year - dateTime asDateAndTime year)+1 min: 11))
]
