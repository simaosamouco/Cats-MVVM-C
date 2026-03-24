//
//  AppThemeUseCaseTests.swift
//  CatsTests
//

import Testing
@testable import Cats

@Suite("AppThemeUseCase")
struct AppThemeUseCaseTests {

    // MARK: - Helpers

    private func makeSUT(
        repository: MockConfigurationRepository = MockConfigurationRepository()
    ) -> (AppThemeUseCase, MockConfigurationRepository) {
        (AppThemeUseCase(configurationRepository: repository), repository)
    }

    // MARK: - getCurrentTheme

    @Test("Returns .system when no theme is stored")
    func returnsSystemByDefault() {
        let (sut, _) = makeSUT()

        let theme = sut.getCurrentTheme()

        #expect(theme == .system)
    }

    @Test("Returns the stored .light theme")
    func returnsStoredLightTheme() {
        let (sut, repository) = makeSUT()
        repository.set(Theme.light.value, for: .appTheme)

        let theme = sut.getCurrentTheme()

        #expect(theme == .light)
    }

    @Test("Returns the stored .dark theme")
    func returnsStoredDarkTheme() {
        let (sut, repository) = makeSUT()
        repository.set(Theme.dark.value, for: .appTheme)

        let theme = sut.getCurrentTheme()

        #expect(theme == .dark)
    }

    @Test("Falls back to .system for an unrecognised raw value")
    func fallsBackToSystemForUnknownValue() {
        let (sut, repository) = makeSUT()
        repository.set(999, for: .appTheme)

        let theme = sut.getCurrentTheme()

        #expect(theme == .system)
    }

    // MARK: - switchTheme

    @Test("switchTheme persists the selected theme value")
    func switchThemePersistsValue() {
        let (sut, repository) = makeSUT()

        sut.switchTheme(to: .dark)

        let stored: Int? = repository.get(for: .appTheme, as: Int.self)
        #expect(stored == Theme.dark.value)
    }

    @Test("switchTheme overwrites a previously stored theme")
    func switchThemeOverwritesPreviousValue() {
        let (sut, repository) = makeSUT()
        repository.set(Theme.light.value, for: .appTheme)

        sut.switchTheme(to: .dark)

        let stored: Int? = repository.get(for: .appTheme, as: Int.self)
        #expect(stored == Theme.dark.value)
    }

    @Test("getCurrentTheme reflects value written by switchTheme")
    func getCurrentThemeReflectsSwitchedTheme() {
        let (sut, _) = makeSUT()

        sut.switchTheme(to: .light)
        let theme = sut.getCurrentTheme()

        #expect(theme == .light)
    }
}
