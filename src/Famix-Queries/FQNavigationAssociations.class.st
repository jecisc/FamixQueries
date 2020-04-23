Class {
	#name : #FQNavigationAssociations,
	#superclass : #FQAbstractNavigationAssociations,
	#instVars : [
		'associations'
	],
	#category : #'Famix-Queries-Navigation-Strategies'
}

{ #category : #'instance creation' }
FQNavigationAssociations class >> with: aFamixClass [
	^ self new
		associations: {aFamixClass} asOrderedCollection;
		yourself
]

{ #category : #'instance creation' }
FQNavigationAssociations class >> withAll: aCollection [
	| associations |
	associations := aCollection asOrderedCollection
		removeAllSuchThat: #isNil.
	associations
		ifEmpty: [ FQCannotRemoveLastNavigationAssociation
				signal: 'You cannot create a navigation query without associations' ].
	^ self new
		associations: associations;
		yourself
]

{ #category : #'adding - removing' }
FQNavigationAssociations >> addAssociation: anAssociation [
	(self associations includes: anAssociation)
		ifTrue: [ ^ self ].
	self
		flag:
			'Removing this first conditional (if associations is a Set) changes checkboxes in the corresponding presenter. Should be revised when tests are ok.'.
	self associations add: anAssociation.
	(self associations includesAll: self class allPossibleAssociations)
		ifTrue: [ ^ FQAllNavigationAssociations new ]
]

{ #category : #accessing }
FQNavigationAssociations >> associations [
	^ associations
]

{ #category : #accessing }
FQNavigationAssociations >> associations: anObject [
	associations := anObject
]

{ #category : #printing }
FQNavigationAssociations >> displayIncomingOn: aStream [
	"The condition is not really needed since the generated script of one branch will be valid all the time, but it is present to print a nicer script to the user."

	self associations size = 1
		ifTrue: [ aStream
				<< '(entity queryIncoming: ';
				print: self associations anyOne;
				<< ') opposites' ]
		ifFalse: [ aStream << '({ '.
			self associations do: [ :asso | aStream print: asso ] separatedBy: [ aStream << ' . ' ].
			aStream << ' } flatCollect: [ :association | (entity queryIncoming: association) opposites ])' ]
]

{ #category : #printing }
FQNavigationAssociations >> displayLocalIncomingOn: aStream [
	"The condition is not really needed since the generated script of one branch will be valid all the time, but it is present to print a nicer script to the user."

	self associations size = 1
		ifTrue: [ aStream
				<< '(entity queryLocalIncoming: ';
				print: self associations anyOne;
				<< ') opposites' ]
		ifFalse: [ aStream << '({ '.
			self associations
				do: [ :asso | aStream print: asso ]
				separatedBy: [ aStream << ' . ' ].
			aStream
				<<
					' } flatCollect: [ :association | (entity queryLocalIncoming: association) opposites ])' ]
]

{ #category : #printing }
FQNavigationAssociations >> displayLocalOutgoingOn: aStream [
	"The condition is not really needed since the generated script of one branch will be valid all the time, but it is present to print a nicer script to the user."

	self associations size = 1
		ifTrue: [ aStream
				<< 'entity queryLocalOutgoing: ';
				print: self associations anyOne;
				<< ') opposites' ]
		ifFalse: [ aStream << '({ '.
			self associations
				do: [ :asso | aStream print: asso ]
				separatedBy: [ aStream << ' . ' ].
			aStream
				<<
					' } flatCollect: [ :association | (entity queryLocalOutgoing: association) opposites ])' ]
]

{ #category : #printing }
FQNavigationAssociations >> displayOutgoingOn: aStream [
	"The condition is not really needed since the generated script of one branch will be valid all the time, but it is present to print a nicer script to the user."

	self associations size = 1
		ifTrue: [ aStream
				<< 'entity queryOutgoing: ';
				print: self associations anyOne;
				<< ') opposites' ]
		ifFalse: [ aStream << '({ '.
			self associations do: [ :asso | aStream print: asso ] separatedBy: [ aStream << ' . ' ].
			aStream << ' } flatCollect: [ :association | (entity queryOutgoing: association) opposites ])' ]
]

{ #category : #initialization }
FQNavigationAssociations >> initialize [
	super initialize.
	associations := OrderedCollection new.
	self flag: 'This is not a Set only because of displayOn tests.'
]

{ #category : #action }
FQNavigationAssociations >> queryIncomingWith: anEntity [
	^ self associations flatCollect: [ :each | (anEntity queryIncoming: each) opposites ]
]

{ #category : #action }
FQNavigationAssociations >> queryLocalIncomingWith: anEntity [
	^ self associations flatCollect: [ :each | (anEntity queryLocalIncoming: each) opposites ]
]

{ #category : #action }
FQNavigationAssociations >> queryLocalOutgoingWith: anEntity [
	^ self associations
		flatCollect: [ :each | (anEntity queryLocalOutgoing: each) opposites ]
]

{ #category : #action }
FQNavigationAssociations >> queryOutgoingWith: anEntity [
	^ self associations flatCollect: [ :each | (anEntity queryOutgoing: each) opposites ]
]

{ #category : #removing }
FQNavigationAssociations >> removeAssociation: anAssociation [
	self associations size == 1
		ifTrue: [ FQCannotRemoveLastNavigationAssociation
				signal:
					'Removing the last association of a ' , self className
						, ' is forbidden' ].
	self associations remove: anAssociation
]