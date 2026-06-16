Class {
	#name : 'LogFile',
	#superclass : 'Object',
	#instVars : [
		'repo',
		'path'
	],
	#category : 'GitBlame-LogModel',
	#package : 'GitBlame',
	#tag : 'LogModel'
}

{ #category : 'accessing' }
LogFile >> path [
	^ path
]

{ #category : 'accessing' }
LogFile >> path: anObject [
	path := anObject
]

{ #category : 'as yet unclassified' }
LogFile >> printOn: aStream [
	path printOn: aStream.
	 ' ' printOn: aStream.
	 repo printOn: aStream
]

{ #category : 'accessing' }
LogFile >> repo [
	^ repo
]

{ #category : 'accessing' }
LogFile >> repo: anObject [
	repo := anObject
]
