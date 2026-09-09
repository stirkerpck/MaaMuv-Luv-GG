<!-- markdownlint-disable MD033 MD041 -->
<p align="center">
  <img alt="LOGO" src="https://cdn.jsdelivr.net/gh/MaaAssistantArknights/design@main/v1/icons/maa-logo_512x512.png" width="256" height="256" />
</p>

<div align="center">

# MuvLuv GG 自动刷图与装备强化

</div>

基于 [MaaFramework](https://github.com/MaaXYZ/MaaFramework) 与 [MFAAvalonia](https://github.com/MaaXYZ/MFAAvalonia) 的 Muv-Luv GG 自动化脚本：自动探索迷宫、刷图，并完成装备强化。

> 本项目为通用 UI（MFAAvalonia）项目，通过 ADB 连接安卓模拟器执行。

## 快速开始

1. 下载并解压本项目的 Release 包。
2. 打开 `MFAAvalonia.exe`。
3. 在「连接设置」中配置你的模拟器（见下方「模拟器连接」）。
4. 连接成功后，在任务列表勾选「自动刷图与装备强化」，填写刷图轮数，点击开始。

## 模拟器连接

本项目使用 MAA 通用 ADB 控制器连接模拟器，**不绑定特定模拟器品牌**，MuMu、雷电、夜神、逍遥等均可使用，只需在「连接设置」里填入对应模拟器的 ADB 地址。

### 使用 MuMu 模拟器

- **支持**：MuMu 12、MuMu 6 均可使用。
- **开启 ADB 调试**：在 MuMu 设置 → 其他 中打开「ADB 调试」。
- **ADB 地址**：
  - MuMu 12：`127.0.0.1:16384`
  - MuMu 6 / 旧版：`127.0.0.1:7555`
- **连接测试**：命令行执行 `adb connect 127.0.0.1:16384`，显示 `connected` 即为成功。

> **重要：必须关闭「截图增强」！**
> MuMu 12 默认开启「截图增强」，会导致 MAA 截图花屏、图像/文字识别全部失败。请在 MuMu 设置中关闭它，否则脚本能连上但无法运行。

### 使用雷电模拟器（LDPlayer）

- 默认 ADB 地址：`127.0.0.1:5555`。
- 在雷电设置中开启「ADB 调试」。

### 使用夜神模拟器

- 默认 ADB 地址：`127.0.0.1:62001`。

### 分辨率

项目使用 `display_short_side: 720`，MAA 会按短边 720 缩放识别。模拟器窗口分辨率不影响识别，只要 ADB 能连上即可。

## 常见问题

- 连不上模拟器：确认已开启 ADB 调试、地址正确、模拟器已启动。
- 连上但识别失败：MuMu 用户请先关闭「截图增强」。
- 任务开始没反应：确认已成功连接模拟器，且已进入 Muv-Luv GG 游戏界面。

## 鸣谢

本项目由 [MaaFramework](https://github.com/MaaXYZ/MaaFramework) 与 [MFAAvalonia](https://github.com/MaaXYZ/MFAAvalonia) 强力驱动。
