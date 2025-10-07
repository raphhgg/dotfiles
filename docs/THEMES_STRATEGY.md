# Application Themes

This document tracks the themes used across different applications to maintain visual consistency.

## Current Theme Configuration

### Zen Browser
- **Theme**: Catppuccin Macchiato Mauve
- **Source**: https://github.com/catppuccin/zen-browser

### Tmux
- **Theme**: Catppuccin Mocha
- **Configuration**: `tmux/themes/catppuccin-theme.conf`

### Zed Editor
- **Theme**: Tokyo Night

## Theme Consistency Goals

The goal is to maintain visual uniformity across all applications. Consider these guidelines when adding new applications:

1. **Primary preference**: Catppuccin variants (Macchiato/Mocha)
2. **Secondary preference**: Tokyo Night variants
3. **Accent colors**: Mauve/Purple tones when available

## Adding New Applications

When configuring themes for new applications:

1. Check if Catppuccin theme is available
2. If not available, look for Tokyo Night variants
3. Choose themes that complement the existing color palette
4. Update this document with the new configuration

## Catppuccin Variants

- **Latte**: Light theme
- **Frappé**: Medium contrast
- **Macchiato**: High contrast (preferred for browsers)
- **Mocha**: Darkest theme (preferred for terminals/editors)