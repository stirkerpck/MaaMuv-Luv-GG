<!-- markdownlint-disable MD033 MD041 -->
<p align="center">
  <img alt="LOGO" src="https://cdn.jsdelivr.net/gh/MaaAssistantArknights/design@main/v1/icons/maa-logo_512x512.png" width="256" height="256" />
</p>

<div align="center">

# MuvLuv GG 自动刷图与强化

</div>

基于 [MaaFramework](https://github.com/MaaXYZ/MaaFramework) 与 [MFAAvalonia](https://github.com/MaaXYZ/MFAAvalonia) 的 Muv-Luv GG 自动化脚本：自动探索迷宫、刷图，并完成装备与アーティファクト强化。

> 本项目为通用 UI（MFAAvalonia）项目，通过 ADB 连接安卓模拟器执行。

## 功能

- **自动刷图与装备强化**：从游戏启动画面开始，自动处理 TOUCH TO START、登录弹窗与公告，进入迷宫探索；战斗中自动跳过剧情、继续与选择选项，结算后调整倍率并进入装备强化。
- **强化アーティファクト**：与上一条共用同一条探索流程，结束后切换到アーティファクト标签页进行强化，每种类型 5 项。

### 近期更新（v1.0.5）

- 新增「强化アーティファクト」任务：不再需要手动停在指定页面，起点即游戏启动画面，走完探索后自动切到アーティファクト强化。
- 强化流程覆盖物理 / EN / 敏捷三种类型，每种类型按顺序逐项强化（装备 4 项、アーティファクト 5 项）。
- 通过 OCR 识别「最大強化」进行强化，并用 `max1.png` 判断该属性已满，自动跳到下一项。
- 强化过程中一旦识别到「投入」文字，立即停止强化并收尾，避免浪费资源。
- 新增探索过程中的干扰页面处理：休息弹窗、终了弹窗、二选一选项（自动选择上方选项）。
- 刷图轮数改为自由输入，达到设定轮数后停止。
- 移除调等级与エリア選択面板相关流程，画面显示哪个等级就直接执行后续流程。

## 快速开始

1. 下载并解压本项目的 Release 包。
2. 打开 `MFAAvalonia.exe`，它会自动连接已启动的模拟器。
3. 先手动进入 Muv-Luv GG 游戏。
4. 在任务列表选择要执行的任务（「自动刷图与装备强化」可填写刷图轮数），点击开始。

## 常见问题

- 任务开始后没有任何操作：确认模拟器窗口没有被最小化——最小化会导致截图失败，所有识别落空。
- 图像 / 文字识别失败：部分模拟器需要关闭「截图增强」之类的画面增强选项，否则 MAA 截图会花屏。
- 分辨率：项目按短边 720 缩放识别，模拟器窗口分辨率不影响识别结果。

## 鸣谢

本项目由 [MaaFramework](https://github.com/MaaXYZ/MaaFramework) 与 [MFAAvalonia](https://github.com/MaaXYZ/MFAAvalonia) 强力驱动。
