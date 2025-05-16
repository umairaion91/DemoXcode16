//
//  Typalises.swift
//  DemoXcode16
//
//  Created by Admin on 14/05/2025.
//
import UIKit

typealias DataSnapshot = NSDiffableDataSourceSnapshot<SignatoryListView.Section, AnyCellConfigurable>
typealias DemoDataSnapshot = NSDiffableDataSourceSnapshot<DemoListView.Section, AnyCellConfigurable>
typealias LoadingCallback = ((Bool) -> Void)
typealias SimpleCallback = (() -> Void)
typealias DemoItemCallback = ((DemoItem) -> Void)
typealias CoordinatorCompletion = (Result<Void, CoordinatorError>) -> Void
