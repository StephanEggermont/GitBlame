Class {
	#name : 'LogRepository',
	#superclass : 'Object',
	#instVars : [
		'model',
		'repositoryName',
		'log',
		'separator',
		'newline',
		'commitLineParser',
		'aNumberOrMinus',
		'fileChangeLineParser',
		'commitParser',
		'commitsParser',
		'rawLog'
	],
	#category : 'GitBlame-LogModel',
	#package : 'GitBlame',
	#tag : 'LogModel'
}

{ #category : 'as yet unclassified' }
LogRepository >> buildParser [
| clExample fcExample logExample |
clExample := '| 0a1759d | 2025-11-05 14:08 | Your Name | 
'.
separator := $| asPParser.
newline := #newline asPParser.
commitLineParser := separator , (#any asPParser starLazy: separator) flatten, 
	separator, (#any asPParser starLazy: separator) flatten,
	separator, (#any asPParser starLazy: separator) flatten, 
	separator, #space asPParser, newline
	==> [:token | {token second. token fourth. token sixth}].
commitLineParser parse: clExample.
fcExample := '1	0	public/images/refactoring-cards/decompose-conditional.svg
'.
aNumberOrMinus := (#digit asPParser | $- asPParser) plus flatten.
fileChangeLineParser := aNumberOrMinus, #space asPParser star, 
	aNumberOrMinus, #space asPParser star, 
	(#any asPParser starLazy: newline) flatten,
	newline 
	==> [:token | {token first. token third. token fifth}].
fileChangeLineParser parse: fcExample.
logExample := '| 73d9099 | 2025-11-05 13:55 | Your Name | 
6	4	src/ui/CardCreator.ts

| dd6ac4d | 2025-11-05 13:41 | Your Name | 
1	1	src/main2.ts
1	1	src/ui/CardCreator.ts

'.
commitParser := commitLineParser,  
	fileChangeLineParser starLazy  , 
	#newline asPParser 
	==> [:token | Array with: token first with: token second].
commitsParser := commitParser star.
commitsParser  parse: logExample
]

{ #category : 'as yet unclassified' }
LogRepository >> committerFor: aString [
	^model committers detect: [:c | 
		c name = aString] 
	ifNone: [ |c |
		c := LogCommitter new.
		c name: aString.
		c addRepo: self.
		model committers add: c.
		c]
		
]

{ #category : 'as yet unclassified' }
LogRepository >> committersOverTime [
	|view |
	view := GtMondrian new.
	view nodes
		stencil: [:aCommitter | GtMondrianUMLClassElement withDefaultContainer
		label: (aCommitter name)];
	with: (model committers select: [:each | each repos includes: self]) ;
	forEach: [:committer |
		view nodes
			stencil: [:com | 
			 (BlElement new 
						height: 2;
						width: 2;
						margin: (BlInsets all: 1);
						background: (self yearColorFor: com))];
			with: (model commits select: [:each | (each repository = self) and: [each committer = committer]]).
		view layout grid ].
	view layout rectanglePack.
^view
]

{ #category : 'as yet unclassified' }
LogRepository >> fileFor: aPath [
	^model files detect: [:file |
		(file path = aPath) and: [file repo = self]]
	ifNone: [ |f|
		f := LogFile new.
		f repo: self.
		f path: aPath.
		model files add: f.
		f]

]

{ #category : 'as yet unclassified' }
LogRepository >> fillModel [
	log do:
	[:logLine |
		|commit committer file change|
		commit := LogCommit new.
		commit repository: self.
		commit shortHash: logLine first first.
		commit dateTime: logLine first second trim withoutQuoting.
		committer := self committerFor: logLine first third.
		committer addRepo: self.

		commit committer: committer.
		model commits add: commit.
		logLine second do: [:fileLine |
			file := self fileFor: fileLine third.
			change := LogChange new.
			change deleted: fileLine first.
			change added: fileLine second.
			change commit: commit.
			change file: file.
			model changes add: change.
			]
]
	
]

{ #category : 'as yet unclassified' }
LogRepository >> gtCommittersOverTimeFor: aView [
	<gtView>
	^ aView forward
		title: 'Committers over Time';
		priority: 20;
		object: [ self committersOverTime ]
]

{ #category : 'as yet unclassified' }
LogRepository >> log [
	| repo q|
	repo := PureGitRepository on: (model root /repositoryName).
	q := repo queries.
	self buildParser.
	rawLog :=  (q runGitWithArgs: {'log' .'--diff-merges=on' .'--numstat'. '--date=format:''%Y-%m-%d %H:%M'''. '--pretty=format:| %h | %cd | %an | '}).
	^log := commitsParser parse: 
		(String streamContents: [:w | 
			rawLog do: [:each|
				w nextPutAll: each.
				w crlf]])
]

{ #category : 'as yet unclassified' }
LogRepository >> model [
	^ model
]

{ #category : 'as yet unclassified' }
LogRepository >> model: aLogModel [ 
	model := aLogModel.
]

{ #category : 'as yet unclassified' }
LogRepository >> printOn: aStream [
	repositoryName printOn: aStream
]

{ #category : 'accessing' }
LogRepository >> repositoryName [
	^ repositoryName
]

{ #category : 'as yet unclassified' }
LogRepository >> repositoryName: aString [ 
	repositoryName := aString
]

{ #category : 'as yet unclassified' }
LogRepository >> yearColorFor: com [ 
	|yr yearColors|
	yr := (com dateTime first: 4) asInteger.
	yearColors := #(green cyan blue orange yellow red) .
	^ Color perform: (yearColors at: (((yr - 2020) max: 1) min:6)).
]
