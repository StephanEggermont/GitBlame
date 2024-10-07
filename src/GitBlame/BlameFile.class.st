Class {
	#name : #BlameFile,
	#superclass : #Object,
	#instVars : [
		'fileReference',
		'blame',
		'model',
		'commits',
		'chunks'
	],
	#category : #'GitBlame-Model'
}

{ #category : #accessing }
BlameFile class >> on: aFileReference in: aModel [
	^self new
		fileReference: aFileReference;
		model: aModel;
		yourself
]

{ #category : #'as yet unclassified' }
BlameFile >> blame: lines [
	blame := lines
]

{ #category : #'as yet unclassified' }
BlameFile >> commits [
	^commits
]

{ #category : #'as yet unclassified' }
BlameFile >> fileReference [
	^ fileReference
]

{ #category : #accessing }
BlameFile >> fileReference: aFileReference [ 
	fileReference := aFileReference
]

{ #category : #'as yet unclassified' }
BlameFile >> initialize [
	commits := IdentitySet new.
	chunks := IdentitySet new.
]

{ #category : #accessing }
BlameFile >> model: aModel [ 
	model := aModel
]

{ #category : #'as yet unclassified' }
BlameFile >> parse [
	| commit chunk |
	blame lines withIndexDo: [ :line :index|
		commit := model commitAt: (line first: 12).
		chunk := commit chunkFor: fileReference.
		chunk lines add: index.
		commits add: commit.
		chunks add: chunk.
		]
]
