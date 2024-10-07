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
