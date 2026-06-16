Class {
	#name : 'LogCommit',
	#superclass : 'Object',
	#instVars : [
		'shortHash',
		'dateTime',
		'committer',
		'repository'
	],
	#category : 'GitBlame-LogModel',
	#package : 'GitBlame',
	#tag : 'LogModel'
}

{ #category : 'accessing' }
LogCommit >> committer [
	^ committer
]

{ #category : 'accessing' }
LogCommit >> committer: anObject [
	committer := anObject
]

{ #category : 'accessing' }
LogCommit >> dateTime [
	^ dateTime
]

{ #category : 'accessing' }
LogCommit >> dateTime: anObject [
	dateTime := anObject
]

{ #category : 'accessing' }
LogCommit >> repository [
	^ repository
]

{ #category : 'accessing' }
LogCommit >> repository: anObject [
	repository := anObject
]

{ #category : 'accessing' }
LogCommit >> shortHash [
	^ shortHash
]

{ #category : 'accessing' }
LogCommit >> shortHash: anObject [
	shortHash := anObject
]
