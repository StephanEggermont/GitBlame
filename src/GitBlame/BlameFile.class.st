Class {
	#name : #BlameFile,
	#superclass : #Object,
	#instVars : [
		'fileReference',
		'blame',
		'model'
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
BlameFile >> fileReference [
	^ fileReference
]

{ #category : #accessing }
BlameFile >> fileReference: aFileReference [ 
	fileReference := aFileReference
]

{ #category : #accessing }
BlameFile >> model: aModel [ 
	model := aModel
]
