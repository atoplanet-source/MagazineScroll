# Known Issues

## Current Issues

### Fonts
**Issue**: Inter font not bundled
**Impact**: App uses system font fallback
**Resolution**: Download Inter-Black.ttf and Inter-ExtraBold.ttf from Google Fonts, add to Resources/Fonts/

### Images
**Issue**: No actual images in sample data
**Impact**: Image slides show placeholder or load from URLs
**Resolution**: Add local images or use valid remote URLs in SampleData.swift

## Potential Issues

### Memory
**Concern**: Large images could consume memory
**Mitigation**: ImageCache has max size limit, LazyVStack defers rendering

### Performance
**Concern**: Many slides could slow scroll
**Mitigation**: LazyVStack only renders visible slides

## Fixed Issues

None yet - this is the initial build.

## Reporting Issues

When encountering issues:
1. Note the exact behavior
2. Include device/simulator used
3. Include iOS version
4. Add reproduction steps
5. Log in SESSION_LOG.md and update this file
