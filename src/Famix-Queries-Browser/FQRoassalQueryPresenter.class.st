Class {
	#name : #FQRoassalQueryPresenter,
	#superclass : #SpRoassalPresenter,
	#category : #'Famix-Queries-Browser-Presenters'
}

{ #category : #'accessing model' }
FQRoassalQueryPresenter >> adaptToOwner [
	self script: [ :canvas | self roassalScript: canvas ]
]

{ #category : #'roassal script' }
FQRoassalQueryPresenter >> boxDraggedAction: event [
	| potentialParents |
	owner selectedQuery: event shape model.
	potentialParents := event canvas shapes
		select: [ :shape | 
			(shape isKindOf: RSBox)
				and: [ shape ~= event shape
						and: [ shape encompassingRectangle
								intersects: event shape encompassingRectangle ] ] ].
	potentialParents size == 1
		ifTrue: [ owner
				addUnionQueryBetween: potentialParents first model
				and: event shape model ].
	self refresh
]

{ #category : #'roassal script' }
FQRoassalQueryPresenter >> boxLabel [
	| label |
	label := RSLabeled new
		text: [ :model | model label substrings first ].
	label location
		inner;
		middle.
	^ label
]

{ #category : #'roassal script' }
FQRoassalQueryPresenter >> boxMenu: aMenuMorph box: aBox [
	(aMenuMorph
		add: 'Create a new query after this one'
		target: self
		selector: #openQueryCreationPresenter)
		icon: (UITheme iconNamed: #add).
	(aMenuMorph
		add: 'Inspect query'
		target: aBox model
		selector: #inspect) icon: (UITheme iconNamed: #inspect).
	aBox model == owner initialQuery
		ifTrue: [ ^ self ].
	(aMenuMorph
		add: 'Remove this query'
		target: self
		selector: #removeQuery:
		argumentList: {aBox model}) icon: (UITheme iconNamed: #remove)
]

{ #category : #'roassal script' }
FQRoassalQueryPresenter >> boxPopup [
	| label |
	label := RSPopup new text: [ :model | model label ].
	^ label
]

{ #category : #'roassal script' }
FQRoassalQueryPresenter >> boxSelection: event [
	owner selectedQuery: event shape model.
	self refresh
]

{ #category : #'roassal script' }
FQRoassalQueryPresenter >> boxSize [
	^ 90
]

{ #category : #'roassal script' }
FQRoassalQueryPresenter >> buildBoxFor: aQueryWrapper [
	| box |
	box := RSBox new
		size: self boxSize;
		model: aQueryWrapper;
		color: aQueryWrapper color;
		addInteraction: self boxLabel;
		addInteraction: self boxPopup;
		when: RSMouseClick do: [ :event | self boxSelection: event ];
		when: RSMouseDoubleClick
			do: [ :event | self openQueryCreationPresenter ];
		when: RSMouseDragEnd do: [ :event | self boxDraggedAction: event ];
		yourself.
	self decorateSelectedBox: box.
	^ box
]

{ #category : #'roassal script' }
FQRoassalQueryPresenter >> decorateSelectedBox: box [
	box model == owner selectedQuery
		ifTrue: [ box border: RSBorder new ]
]

{ #category : #'accessing model' }
FQRoassalQueryPresenter >> openQueryCreationPresenter [
	(FQQueryCreationPresenter on: owner) openWithSpec
]

{ #category : #'roassal script' }
FQRoassalQueryPresenter >> removeQuery: aQuery [
	owner removeQuery: aQuery.
	self refresh
]

{ #category : #'roassal script' }
FQRoassalQueryPresenter >> roassalScript: canvas [
	| boxes |
	boxes := owner queries
		collect: [ :queryWrapper | self buildBoxFor: queryWrapper ]
		as: RSGroup.
	boxes @ RSDraggable.
	boxes
		@
			(RSMenuActivable new
				menuDo: [ :menu :box | self boxMenu: menu box: box ]).
	canvas addAll: boxes.
	RSEdgeBuilder line
		canvas: canvas;
		attachPoint: RSBorderAttachPoint new;
		shapes: boxes;
		connectToAll: #children.
	RSDominanceTreeLayout on: canvas nodes.
	canvas @ RSCanvasController.
	^ canvas
]

{ #category : #update }
FQRoassalQueryPresenter >> selectItem: aQuery [
	self refresh
]