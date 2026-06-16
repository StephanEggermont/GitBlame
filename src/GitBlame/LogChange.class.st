Class {
	#name : 'LogChange',
	#superclass : 'Object',
	#instVars : [
		'file',
		'commit',
		'deleted',
		'added'
	],
	#category : 'GitBlame-LogModel',
	#package : 'GitBlame',
	#tag : 'LogModel'
}

{ #category : 'accessing' }
LogChange >> added [
	^ added
]

{ #category : 'accessing' }
LogChange >> added: anObject [
	added := anObject
]

{ #category : 'accessing' }
LogChange >> commit [
	^ commit
]

{ #category : 'accessing' }
LogChange >> commit: anObject [
	commit := anObject
]

{ #category : 'accessing' }
LogChange >> deleted [
	^ deleted
]

{ #category : 'accessing' }
LogChange >> deleted: anObject [
	deleted := anObject
]

{ #category : 'accessing' }
LogChange >> file [
	^ file
]

{ #category : 'accessing' }
LogChange >> file: anObject [
	file := anObject
]
