import SwiftUI

// MARK: - Settings View

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var cloudKit = CloudKitManager.shared

    // Local editable state
    @State private var selectedCategories: Set<String> = []
    @State private var eraPreference: EraPreference = .both
    @State private var contentTone: ContentTone = .fun
    @State private var discoveryMode: DiscoveryMode = .balanced
    @State private var readingGoal: ReadingGoal = .regular

    // Sheet state
    @State private var showingEraPicker = false
    @State private var showingTonePicker = false
    @State private var showingDiscoveryPicker = false
    @State private var showingGoalPicker = false

    private let allCategories = [
        "Economics", "Ancient World", "Medieval", "20th Century",
        "19th Century", "Science", "Art", "Crime", "Exploration", "War"
    ]

    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 24) {
                    // Category Toggles
                    categoriesSection

                    // Reading Preferences
                    preferencesSection
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .padding(.bottom, 40)
            }
            .background(Color(hex: "#F5F4F0"))
            .navigationTitle("Preferences")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        saveAndDismiss()
                    }
                    .font(.system(size: 16, weight: .semibold))
                }
            }
            .onAppear {
                loadPreferences()
            }
        }
        .sheet(isPresented: $showingEraPicker) {
            PreferencePickerSheet(
                title: "Era Preference",
                options: EraPreference.allCases,
                selected: $eraPreference,
                displayName: { era in
                    switch era {
                    case .ancient: return "Ancient"
                    case .modern: return "Modern"
                    case .both: return "Both"
                    }
                }
            )
            .presentationDetents([.height(280)])
        }
        .sheet(isPresented: $showingTonePicker) {
            PreferencePickerSheet(
                title: "Content Vibe",
                options: ContentTone.allCases,
                selected: $contentTone,
                displayName: { $0.displayName }
            )
            .presentationDetents([.height(220)])
        }
        .sheet(isPresented: $showingDiscoveryPicker) {
            PreferencePickerSheet(
                title: "Discovery Mode",
                options: DiscoveryMode.allCases,
                selected: $discoveryMode,
                displayName: { $0.displayName }
            )
            .presentationDetents([.height(280)])
        }
        .sheet(isPresented: $showingGoalPicker) {
            PreferencePickerSheet(
                title: "Reading Goal",
                options: ReadingGoal.allCases,
                selected: $readingGoal,
                displayName: { $0.displayName }
            )
            .presentationDetents([.height(280)])
        }
    }

    // MARK: - Categories Section (Editable)

    private var categoriesSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionHeader(title: "Your Topics", icon: "square.grid.2x2.fill")

            VStack(spacing: 0) {
                ForEach(Array(allCategories.enumerated()), id: \.element) { index, category in
                    CategoryToggleRow(
                        category: category,
                        isSelected: selectedCategories.contains(category),
                        onToggle: { toggleCategory(category) }
                    )

                    if index < allCategories.count - 1 {
                        Divider().padding(.horizontal, 16)
                    }
                }
            }
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))

            // Minimum categories hint
            if selectedCategories.count == 1 {
                Text("At least 1 category required")
                    .font(.system(size: 12))
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, 4)
            }
        }
    }

    // MARK: - Preferences Section (Editable)

    private var preferencesSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionHeader(title: "Reading Style", icon: "slider.horizontal.3")

            VStack(spacing: 0) {
                PreferencePickerRow(
                    label: "Era Preference",
                    value: eraPreference == .ancient ? "Ancient" :
                           eraPreference == .modern ? "Modern" : "Both",
                    onTap: { showingEraPicker = true }
                )

                Divider().padding(.horizontal, 16)

                PreferencePickerRow(
                    label: "Content Vibe",
                    value: contentTone.displayName,
                    onTap: { showingTonePicker = true }
                )

                Divider().padding(.horizontal, 16)

                PreferencePickerRow(
                    label: "Discovery Mode",
                    value: discoveryMode.displayName,
                    onTap: { showingDiscoveryPicker = true }
                )

                Divider().padding(.horizontal, 16)

                PreferencePickerRow(
                    label: "Reading Goal",
                    value: readingGoal.displayName,
                    onTap: { showingGoalPicker = true }
                )
            }
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }

    // MARK: - Helpers

    private func loadPreferences() {
        let prefs = cloudKit.userPreferences
        selectedCategories = Set(prefs.selectedCategories)
        eraPreference = prefs.eraPreference
        contentTone = prefs.contentTone
        discoveryMode = prefs.discoveryMode
        readingGoal = prefs.readingGoal
    }

    private func toggleCategory(_ category: String) {
        if selectedCategories.contains(category) {
            // Don't allow deselecting if it's the last one
            if selectedCategories.count > 1 {
                selectedCategories.remove(category)
            }
        } else {
            selectedCategories.insert(category)
        }
    }

    private func saveAndDismiss() {
        var preferences = cloudKit.userPreferences
        preferences.selectedCategories = Array(selectedCategories)
        preferences.eraPreference = eraPreference
        preferences.contentTone = contentTone
        preferences.discoveryMode = discoveryMode
        preferences.readingGoal = readingGoal
        cloudKit.updatePreferences(preferences)
        dismiss()
    }
}

// MARK: - Category Toggle Row

struct CategoryToggleRow: View {
    let category: String
    let isSelected: Bool
    let onToggle: () -> Void

    private var color: String {
        CategoryColors.color(for: category)
    }

    var body: some View {
        Button(action: onToggle) {
            HStack(spacing: 12) {
                // Category color dot
                Circle()
                    .fill(Color(hex: color))
                    .frame(width: 12, height: 12)

                // Category name
                Text(category)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(.black)

                Spacer()

                // Checkmark
                if isSelected {
                    Image(systemName: "checkmark")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(Color(hex: color))
                }
            }
            .padding(16)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Preference Picker Row (Tappable)

struct PreferencePickerRow: View {
    let label: String
    let value: String
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack {
                Text(label)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(.black.opacity(0.7))

                Spacer()

                Text(value)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(.black)

                Image(systemName: "chevron.right")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(.black.opacity(0.3))
            }
            .padding(16)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Preference Picker Sheet

struct PreferencePickerSheet<T: Hashable>: View {
    let title: String
    let options: [T]
    @Binding var selected: T
    let displayName: (T) -> String

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            List {
                ForEach(options, id: \.self) { option in
                    Button {
                        selected = option
                        dismiss()
                    } label: {
                        HStack {
                            Text(displayName(option))
                                .foregroundStyle(.black)

                            Spacer()

                            if option == selected {
                                Image(systemName: "checkmark")
                                    .foregroundStyle(Color(hex: "#2E5090"))
                            }
                        }
                    }
                }
            }
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

// MARK: - Section Header

struct SectionHeader: View {
    let title: String
    let icon: String

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(Color(hex: "#2E5090"))

            Text(title)
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(.black)
        }
    }
}

// MARK: - Category Chip (kept for backwards compatibility)

struct CategoryChip: View {
    let category: String

    private var color: String {
        CategoryColors.color(for: category)
    }

    var body: some View {
        Text(category)
            .font(.system(size: 13, weight: .semibold))
            .foregroundStyle(.white)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(Color(hex: color))
            .clipShape(Capsule())
    }
}

// MARK: - Flow Layout

struct FlowLayout: Layout {
    var spacing: CGFloat = 8

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let result = FlowResult(
            in: proposal.width ?? 0,
            subviews: subviews,
            spacing: spacing
        )
        return CGSize(width: proposal.width ?? 0, height: result.height)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let result = FlowResult(
            in: bounds.width,
            subviews: subviews,
            spacing: spacing
        )
        for (index, subview) in subviews.enumerated() {
            subview.place(at: CGPoint(x: bounds.minX + result.positions[index].x,
                                      y: bounds.minY + result.positions[index].y),
                         proposal: .unspecified)
        }
    }

    struct FlowResult {
        var positions: [CGPoint] = []
        var height: CGFloat = 0

        init(in maxWidth: CGFloat, subviews: Subviews, spacing: CGFloat) {
            var x: CGFloat = 0
            var y: CGFloat = 0
            var rowHeight: CGFloat = 0

            for subview in subviews {
                let size = subview.sizeThatFits(.unspecified)

                if x + size.width > maxWidth && x > 0 {
                    x = 0
                    y += rowHeight + spacing
                    rowHeight = 0
                }

                positions.append(CGPoint(x: x, y: y))
                rowHeight = max(rowHeight, size.height)
                x += size.width + spacing
            }

            height = y + rowHeight
        }
    }
}

#Preview {
    SettingsView()
}
