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

{ #category : 'accessing' }
LogModel >> addAllRepositoriesInRoot [
]

{ #category : 'accessing' }
LogModel >> addRepositoriesInRoot [
	self root directories do: [ :dir |
		self addRepository: dir basename]
]

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

{ #category : 'as yet unclassified' }
LogModel >> committersOverTime [
	|view |
	view := GtMondrian new.
	view nodes
		stencil: [:aCommitter | BlElement new
													constraintsDo: [ :c | 
											c vertical fitContent.
											c horizontal fitContent];

			    padding: (BlInsets all: 1);
			    margin: (BlInsets all: 2);
			    border: Color gray];
	with: (self committers ) ;
	forEach: [:committer |
		view nodes
			stencil: [:repo |
				GtMondrianUMLClassElement withDefaultContainer
					label: ((repo repositoryName) contractTo: 10);
					margin: (BlInsets all: 1)
];
		with: committer repos ;
	  forEach: [:repo | 
			view nodes
			stencil: [:com | 
				 (BlElement new 
						height: 2;
						width: 2;
						margin: (BlInsets all: 1);
						background: (self yearColorFor: com))];
			with: (self commits select: [:each | (each repository = repo) and: [each committer = committer]]).
		view layout grid ].
		view layout rectanglePack].
	view layout rectanglePack.
^view
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
LogModel >> gtCommittersOverTimeFor: aView [
	<gtView>
	^ aView forward
		title: 'Committers over Time';
		priority: 20;
		object: [ self committersOverTime ]
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
LogModel >> parseAll [
	self repositories do: [:repo |
		repo log.
		repo fillModel]
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

{ #category : 'as yet unclassified' }
LogModel >> yearColorFor: com [ 
	|yr yearColors|
	yr := (com dateTime first: 4) asInteger.
	yearColors := #(green cyan blue orange yellow red brown gray) .
	^ Color perform: (yearColors at: (((yr - 2018) max: 1) min:8)).
]
