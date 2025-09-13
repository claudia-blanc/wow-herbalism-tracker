# Herbalism Tracker

A World of Warcraft Classic addon that automatically tracks herbalism nodes and displays them on the world map.

![WoW Classic](https://img.shields.io/badge/WoW-Classic-orange)
![Interface](https://img.shields.io/badge/Interface-11507-blue)
![Version](https://img.shields.io/badge/Version-1.0.0-green)
![License](https://img.shields.io/badge/License-MIT-yellow)

## Features

- 🌿 **Automatic Detection**: Records herb locations when you harvest them
- 🗺️ **Map Integration**: Shows herb icons on the world map
- 💾 **Persistent Storage**: Saves locations between game sessions
- 🎨 **Color-Coded Icons**: Each herb type has distinctive colors
- 🔧 **Easy Management**: Simple commands and right-click removal
- 📊 **Statistics**: Track your herb collection progress

## Installation

### Method 1: Manual Installation
1. Download the latest release from the [Releases](../../releases) page
2. Extract to your WoW Classic addons folder:
   ```
   World of Warcraft\_classic_\Interface\AddOns\HerbalismTracker\
   ```
3. Restart WoW or type `/reload` in-game
4. Enable the addon in your AddOns menu

### Method 2: Git Clone (for developers)
```bash
cd "World of Warcraft\_classic_\Interface\AddOns\"
git clone https://github.com/YOUR_USERNAME/wow-herbalism-tracker.git HerbalismTracker
```

## Quick Start

1. **Install and enable** the addon
2. **Go herb picking** - the addon automatically detects when you harvest herbs
3. **Open your map** (M key) to see herb icons
4. **Hover over icons** for details, **right-click to remove**

## Commands

| Command | Description |
|---------|-------------|
| `/herbs` | Show help menu |
| `/herbs toggle` | Show/hide herb icons on map |
| `/herbs clear` | Remove all tracked nodes |
| `/herbs stats` | Display node statistics |

## Supported Herbs

✅ All Classic WoW herbs including:
- **Starter herbs**: Silverleaf, Peacebloom, Earthroot
- **Mid-level**: Kingsblood, Liferoot, Fadeleaf, Khadgar's Whisker
- **High-level**: Arthas' Tears, Sungrass, Golden Sansam, Mountain Silversage
- **Rare spawns**: Black Lotus, Ghost Mushroom
- **And many more!**

## Screenshots

*Screenshots coming soon - show your herb-covered maps!*

## Development

### Requirements
- World of Warcraft Classic client
- Basic knowledge of WoW addon development
- Text editor (VS Code recommended)

### Building from Source
```bash
git clone https://github.com/YOUR_USERNAME/wow-herbalism-tracker.git
cd wow-herbalism-tracker
# Copy files to your AddOns directory
```

### Contributing
1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## Compatibility

- ✅ **WoW Classic Era** (Interface 11507)
- ✅ **WoW Classic Hardcore** 
- ✅ **Season of Discovery** (may require interface update)
- ❌ **Retail WoW** (different herb system)

## FAQ

**Q: Why aren't my herbs showing up?**
A: Make sure you're actually looting the herbs (opening the loot window) and check that map display is enabled with `/herbs toggle`.

**Q: Can I share herb locations with friends?**
A: Not yet, but this feature is planned for a future update!

**Q: The addon shows "Out of Date"**
A: Check for updates or manually update the Interface version in the .toc file.

## Roadmap

- [ ] Customizable icon sizes and transparency
- [ ] Import/export herb databases
- [ ] Guild/party herb sharing
- [ ] Filtering by herb type
- [ ] Respawn timer estimates
- [ ] Integration with other gathering addons

## Support

- 🐛 **Bug Reports**: [Create an issue](../../issues)
- 💡 **Feature Requests**: [Create an issue](../../issues)
- 💬 **Questions**: Check existing [discussions](../../discussions)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Thanks to the WoW Classic community
- Inspired by classic gathering addons
- Built with love for fellow herb farmers

---

**Happy herb hunting!** 🌿

*Star this repo if it helped you create better farming routes!*