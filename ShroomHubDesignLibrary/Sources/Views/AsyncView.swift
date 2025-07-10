//
//  AsyncView.swift
//  ShroomHubDesignLibrary
//
//  Created by Catalin Lucaciu on 27.04.2025.
//


import SwiftUI
import SHUtils

public struct AsyncView<Content>: View where Content: View {
    @ViewBuilder var content: () -> Content
    
    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    public var body: some View {
        content()
    }
}

public struct AsyncTaskView<Value: Sendable, Content, Empty, Placeholder>: View where Content: View, Empty: View, Placeholder: View {
    let task: () async throws -> Value
    let failureAction: (() -> Void)?
    @ViewBuilder var empty: () -> Empty
    @ViewBuilder var content: (Value) -> Content
    @ViewBuilder var placeholder: () -> Placeholder
    @State private var state: LoadableState<Value, Error> = .idle
    
    public var body: some View {
        AsyncStateView(state: $state,
                       task: task,
                       failureAction: failureAction,
                       empty: empty,
                       content: content,
                       placeholder: placeholder)
    }
}

public struct AsyncStateView<Value: Sendable, Content, Empty, Placeholder>: View where Content: View, Empty: View, Placeholder: View {
    @Binding var state: LoadableState<Value, Error>
    let task: () async throws -> Value
    let failureAction: (() -> Void)?
    @ViewBuilder var empty: () -> Empty
    @ViewBuilder var content: (Value) -> Content
    @ViewBuilder var placeholder: () -> Placeholder
    @State private var taskID: UUID = UUID()
    
    public var body: some View {
        Group {
            switch state {
            case .idle:
                placeholder()
            case .loading:
                placeholder()
            case .failure:
                placeholder()
                    .alert(state: $state,
                           confirmAction: failureAction,
                           retryAction: {
                        state = .idle
                    })
            case .empty:
                empty()
            case let .loaded(value):
                content(value)
            }
        }
        .task(id: taskID) {
            if state.isIdle {
                await $state.load(task)
            }
        }
        .onChange(of: state) { state in
            if state.isIdle {
                taskID = UUID()
            }
        }
    }
}

// MARK: - LoadableState
public extension AsyncView {
    init<C>(_ state: Binding<LoadableState<Void, Error>>,
            task: @escaping () async throws -> Void,
            failureAction: (() -> Void)? = nil,
            @ViewBuilder content: @escaping () -> C) where Content == AsyncStateView<Void, C, C, ProgressView<EmptyView, EmptyView>> {
        self.init(state,
                  task: task,
                  failureAction: failureAction,
                  content: content,
                  empty: content)
    }
    
    init<C, E>(_ state: Binding<LoadableState<Void, Error>>,
               task: @escaping () async throws -> Void,
               failureAction: (() -> Void)? = nil,
               @ViewBuilder content: @escaping () -> C,
               @ViewBuilder empty: @escaping () -> E) where Content == AsyncStateView<Void, C, E, ProgressView<EmptyView, EmptyView>> {
        self.init(state,
                  task: task,
                  failureAction: failureAction,
                  content: content,
                  empty: empty,
                  placeholder: { ProgressView() })
    }
    
    init<C, E, P>(_ state: Binding<LoadableState<Void, Error>>,
                  task: @escaping () async throws -> Void,
                  failureAction: (() -> Void)? = nil,
                  @ViewBuilder content: @escaping () -> C,
                  @ViewBuilder empty: @escaping () -> E,
                  @ViewBuilder placeholder: @escaping () -> P) where Content == AsyncStateView<Void, C, E, P> {
        self.init {
            AsyncStateView(state: state,
                           task: task,
                           failureAction: failureAction,
                           empty: empty,
                           content: content,
                           placeholder: placeholder)
        }
    }
    
    init<Value, C>(_ state: Binding<LoadableState<Value, Error>>,
                   task: @escaping () async throws -> Value,
                   failureAction: (() -> Void)? = nil,
                   @ViewBuilder content: @escaping (Value?) -> C) where Content == AsyncStateView<Value, C, C, ProgressView<EmptyView, EmptyView>> {
        self.init(state,
                  task: task,
                  failureAction: failureAction,
                  content: content,
                  empty: { content(nil) })
    }
    
    init<Value, C, E>(_ state: Binding<LoadableState<Value, Error>>,
                      task: @escaping () async throws -> Value,
                      failureAction: (() -> Void)? = nil,
                      @ViewBuilder content: @escaping (Value) -> C,
                      @ViewBuilder empty: @escaping () -> E) where Content == AsyncStateView<Value, C, E, ProgressView<EmptyView, EmptyView>> {
        self.init(state,
                  task: task,
                  failureAction: failureAction,
                  content: content,
                  empty: empty,
                  placeholder: { ProgressView() })
    }
    
    init<Value, C, E, P>(_ state: Binding<LoadableState<Value, Error>>,
                         task: @escaping () async throws -> Value,
                         failureAction: (() -> Void)? = nil,
                         @ViewBuilder content: @escaping (Value) -> C,
                         @ViewBuilder empty: @escaping () -> E,
                         @ViewBuilder placeholder: @escaping () -> P) where Content == AsyncStateView<Value, C, E, P> {
        self.init {
            AsyncStateView(state: state,
                           task: task,
                           failureAction: failureAction,
                           empty: empty,
                           content: content,
                           placeholder: placeholder)
        }
    }
}

// MARK: - Async Task
public extension AsyncView {
    init<C>(task: @escaping () async throws -> Void,
            failureAction: (() -> Void)? = nil,
            @ViewBuilder content: @escaping () -> C) where Content == AsyncTaskView<Void, C, C, ProgressView<EmptyView, EmptyView>> {
        self.init(task: task,
                  failureAction: failureAction,
                  content: content,
                  empty: content)
    }
    
    init<C, E>(task: @escaping () async throws -> Void,
               failureAction: (() -> Void)? = nil,
               @ViewBuilder content: @escaping () -> C,
               @ViewBuilder empty: @escaping () -> E) where Content == AsyncTaskView<Void, C, E, ProgressView<EmptyView, EmptyView>> {
        self.init(task: task,
                  failureAction: failureAction,
                  content: content,
                  empty: empty,
                  placeholder: { ProgressView() })
    }
    
    init<C, E, P>(task: @escaping () async throws -> Void,
                  failureAction: (() -> Void)? = nil,
                  @ViewBuilder content: @escaping () -> C,
                  @ViewBuilder empty: @escaping () -> E,
                  @ViewBuilder placeholder: @escaping () -> P) where Content == AsyncTaskView<Void, C, E, P> {
        self.init {
            AsyncTaskView(task: task,
                          failureAction: failureAction,
                          empty: empty,
                          content: content,
                          placeholder: placeholder)
        }
    }
    
    init<Value, C>(task: @escaping () async throws -> Value,
                   failureAction: (() -> Void)? = nil,
                   @ViewBuilder content: @escaping (Value) -> C) where Content == AsyncTaskView<Value, C, Color, ProgressView<EmptyView, EmptyView>> {
        self.init(task: task,
                  failureAction: failureAction,
                  content: content,
                  empty: {
            /* 
             This case is invalid as LoadableState.empty is managed internally.
             Based on the Task evaluation it can only be .loaded(Value) or .failure(Error)
             */
            Color.red
        })
    }
    
    init<Value, C, E>(task: @escaping () async throws -> Value,
                      failureAction: (() -> Void)? = nil,
                      @ViewBuilder content: @escaping (Value) -> C,
                      @ViewBuilder empty: @escaping () -> E) where Content == AsyncTaskView<Value, C, E, ProgressView<EmptyView, EmptyView>> {
        self.init(task: task,
                  failureAction: failureAction,
                  content: content,
                  empty: empty,
                  placeholder: { ProgressView() })
    }
    
    init<Value: Sendable, C, E, P>(task: @escaping () async throws -> Value,
                         failureAction: (() -> Void)? = nil,
                         @ViewBuilder content: @escaping (Value) -> C,
                         @ViewBuilder empty: @escaping () -> E,
                         @ViewBuilder placeholder: @escaping () -> P) where Content == AsyncTaskView<Value, C, E, P> {
        self.init {
            AsyncTaskView(task: task,
                          failureAction: failureAction,
                          empty: empty,
                          content: content,
                          placeholder: placeholder)
        }
    }
}
