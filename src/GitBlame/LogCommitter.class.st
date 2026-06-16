Class {
	#name : 'LogCommitter',
	#superclass : 'Object',
	#instVars : [
		'name',
		'email',
		'repos'
	],
	#category : 'GitBlame-LogModel',
	#package : 'GitBlame',
	#tag : 'LogModel'
}

{ #category : 'as yet unclassified' }
LogCommitter >> addRepo: aRepository [
	repos add: aRepository
]

{ #category : 'accessing' }
LogCommitter >> email [
	^ email
]

{ #category : 'accessing' }
LogCommitter >> email: anObject [
	email := anObject
]

{ #category : 'as yet unclassified' }
LogCommitter >> initialize [
	repos := Set new.
]

{ #category : 'accessing' }
LogCommitter >> name [
	^ name
]

{ #category : 'accessing' }
LogCommitter >> name: anObject [
	name := anObject
]

{ #category : 'accessing' }
LogCommitter >> repos [
	^ repos
]

{ #category : 'accessing' }
LogCommitter >> repos: anObject [
	repos := anObject
]
