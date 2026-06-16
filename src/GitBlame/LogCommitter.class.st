Class {
	#name : 'LogCommitter',
	#superclass : 'Object',
	#instVars : [
		'repo',
		'name',
		'email'
	],
	#category : 'GitBlame-LogModel',
	#package : 'GitBlame',
	#tag : 'LogModel'
}

{ #category : 'accessing' }
LogCommitter >> email [
	^ email
]

{ #category : 'accessing' }
LogCommitter >> email: anObject [
	email := anObject
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
LogCommitter >> repo [
	^ repo
]

{ #category : 'accessing' }
LogCommitter >> repo: anObject [
	repo := anObject
]
