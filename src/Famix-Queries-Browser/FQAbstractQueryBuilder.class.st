Class {
	#name : #FQAbstractQueryBuilder,
	#superclass : #Object,
	#instVars : [
		'query',
		'entities'
	],
	#category : #'Famix-Queries-Browser-Builder'
}

{ #category : #'plugin interface' }
FQAbstractQueryBuilder class >> newWithEntities: entities [
	^ self basicNew
		entities: entities;
		initialize;
		yourself
]

{ #category : #running }
FQAbstractQueryBuilder >> createQuery [
	^ String streamContents: [ :s | query displayOn: s ]
]

{ #category : #accessing }
FQAbstractQueryBuilder >> entities [
	^ entities
]

{ #category : #accessing }
FQAbstractQueryBuilder >> entities: anObject [
	entities := anObject
]

{ #category : #initialization }
FQAbstractQueryBuilder >> initialize [
	super initialize.
	self initializeQuery
]

{ #category : #running }
FQAbstractQueryBuilder >> initializeQuery [
	query := self queryClass new
]

{ #category : #accessing }
FQAbstractQueryBuilder >> query [
	^ query
]

{ #category : #accessing }
FQAbstractQueryBuilder >> query: anObject [
	query := anObject
]

{ #category : #accessing }
FQAbstractQueryBuilder >> queryClass [
	^ self subclassResponsibility
]