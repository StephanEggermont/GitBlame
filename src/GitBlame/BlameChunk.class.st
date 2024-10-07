Class {
	#name : #BlameChunk,
	#superclass : #Object,
	#instVars : [
		'commit',
		'file',
		'lines',
		'model'
	],
	#category : #'GitBlame-Model'
}

{ #category : #accessing }
BlameChunk >> commit [
	^ commit
]

{ #category : #accessing }
BlameChunk >> commit: anObject [
	commit := anObject
]

{ #category : #accessing }
BlameChunk >> file [
	^ file
]

{ #category : #accessing }
BlameChunk >> file: anObject [
	file := anObject
]

{ #category : #'as yet unclassified' }
BlameChunk >> initialize [
	lines := OrderedCollection new
]

{ #category : #accessing }
BlameChunk >> lines [
	^ lines
]

{ #category : #accessing }
BlameChunk >> lines: anObject [
	lines := anObject
]

{ #category : #accessing }
BlameChunk >> model [
	^ model
]

{ #category : #accessing }
BlameChunk >> model: anObject [
	model := anObject
]
