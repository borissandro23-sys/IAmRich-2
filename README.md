# I Am Rich — Modern Restoration

Restoration of the classic **I Am Rich** iPhone application for modern iOS, based on the original application bundle resources.

## Project layout

```
IAmRich/
├── OriginalResources/          # untouched original files from the .app
├── IAmRichApp/
│   ├── IAmRich.xcodeproj/      # open this in Xcode
│   └── IAmRichApp/             # Swift sources + Assets.xcassets
└── README.md
```

## Original Resources (preserved, never modified)

All original files are in `OriginalResources/`:

| File | Description |
|------|-------------|
| `Rich4.png` | Main screen image (320×480, original CgBI) |
| `IamRichBack1.png` | Flipside image (320×420) |
| `Default.png` | Launch / overlay image (320×480) |
| `icon.png` | Original 57×57 icon |
| `MainView.nib` / `FlipsideView.nib` / `MainWindow.nib` | Interface archives |
| `Info.plist` | Original metadata (bundle ID `9C48YYZAC5.IAmRich`) |
| `IAmRich` | Original ARMv6 Mach-O binary (not executed) |

Converted standard PNGs (from CgBI) are used only inside the Asset Catalog of the modern project.

## Analysis Summary

- **RootViewController**: `infoButton` (InfoLight) + `toggleView` (flip)
- **MainView**: `Rich4.png`, contentMode scaleAspectFill, black background
- **FlipsideView**: `IamRichBack1.png` + translucent `Default.png` (α≈0.47) + black nav bar with Done
- Bundle ID kept: `9C48YYZAC5.IAmRich`
- Deployment target: iOS 15.0

## How to Build

1. Open **`IAmRichApp/IAmRich.xcodeproj`** in Xcode 15+.
2. Signing & Capabilities → select your Development Team.
3. Select iPhone simulator or device → Run (⌘R).
4. For IPA: Product → Archive → Distribute App.

No third-party dependencies.
