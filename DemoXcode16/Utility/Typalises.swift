//
//  Typalises.swift
//  DemoXcode16
//
//  Created by Admin on 14/05/2025.
//
import UIKit

typealias DataSnapshot = NSDiffableDataSourceSnapshot<SignatoryListView.Section, AnyCellConfigurable>
typealias LoadingCallback = ((Bool) -> Void)
typealias SimpleCallback = (() -> Void)
