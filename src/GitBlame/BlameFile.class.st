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

{ #category : #accessing }
BlameFile >> blame [
	^ blame
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
BlameFile >> newestCommitsFirst [
		^commits sorted: [:a :b | 
		a dateTime > b dateTime]
]

{ #category : #'as yet unclassified' }
BlameFile >> parse [
	| commit chunk author |
	blame lines withIndexDo: [ :line :index| |parts|
		parts := line splitOn: Character tab.
		commit := model commitAt: parts first.
		author := model authorAt: (parts second allButFirst trimBoth).
		commit author: author.
		commit dateTime: parts third trimBoth.
		chunk := commit chunkFor: fileReference.
		chunk lines add: index.
		commits add: commit.
		author commits add: commit.
		chunks add: chunk.
		]
]
