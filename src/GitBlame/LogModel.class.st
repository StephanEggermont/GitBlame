Class {
	#name : 'LogModel',
	#superclass : 'Object',
	#instVars : [
		'repositories',
		'root',
		'commits',
		'committers',
		'files',
		'changes'
	],
	#category : 'GitBlame-LogModel',
	#package : 'GitBlame',
	#tag : 'LogModel'
}

{ #category : 'as yet unclassified' }
LogModel >> addRepository: aString [ 
	|repo|
	repo := LogRepository new.
	repo model: self.
	repo repositoryName: aString.
	repositories add: repo.
	^repo
]

{ #category : 'accessing' }
LogModel >> changes [
	^ changes
]

{ #category : 'accessing' }
LogModel >> changes: anObject [
	changes := anObject
]

{ #category : 'accessing' }
LogModel >> commits [
	^ commits
]

{ #category : 'accessing' }
LogModel >> commits: anObject [
	commits := anObject
]

{ #category : 'accessing' }
LogModel >> committers [
	^ committers
]

{ #category : 'accessing' }
LogModel >> committers: anObject [
	committers := anObject
]

{ #category : 'accessing' }
LogModel >> files [
	^ files
]

{ #category : 'accessing' }
LogModel >> files: anObject [
	files := anObject
]

{ #category : 'as yet unclassified' }
LogModel >> initialize [
	repositories := OrderedCollection new.
	commits := OrderedCollection new.
	committers := OrderedCollection new.
	files := OrderedCollection new.
	changes := OrderedCollection new
]

{ #category : 'accessing' }
LogModel >> repositories [
	^ repositories
]

{ #category : 'accessing' }
LogModel >> repositories: anObject [
	repositories := anObject
]

{ #category : 'as yet unclassified' }
LogModel >> root [
	^root
]

{ #category : 'as yet unclassified' }
LogModel >> root: aFileLocator [ 
	root := aFileLocator
]
