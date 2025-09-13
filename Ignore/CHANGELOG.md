# Changelog

All notable changes to the Herbalism Tracker addon will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Planned
- Customizable icon sizes and colors
- Import/export herb databases
- Guild sharing functionality
- Advanced filtering options
- Respawn timer estimates

## [1.0.0] - 2025-08-17

### Added
- Initial release of Herbalism Tracker
- Automatic herb node detection when looting
- World map integration with herb icons
- Persistent storage of herb locations per character
- Interactive tooltips showing herb details and coordinates
- Right-click to remove individual nodes
- Slash commands for addon management
- Support for all Classic WoW herbs (Silverleaf to Black Lotus)
- Color-coded icons for different herb types
- Node statistics and management commands

### Features
- `/herbs toggle` - Show/hide map display
- `/herbs clear` - Remove all tracked nodes
- `/herbs stats` - Display node statistics
- Automatic duplicate node prevention
- Lightweight performance with minimal memory usage

### Technical
- Compatible with WoW Classic Interface 11507
- Per-character saved variables
- Event-driven herb detection system
- Comprehensive herb database with 25+ herb types