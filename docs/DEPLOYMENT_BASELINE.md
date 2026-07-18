# KH 官网上线基线

更新日期：2026-07-18

本文档记录已经确认的视频和部署参数。正式上线前以此基线进行构建与验收。

## 视频播放规则

- 分类页视频使用浏览器原生控件，显示进度条、播放/暂停、时间和音量。
- 视频在案例卡片内直接播放，点击画面不跳转案例页。
- 播放一段新视频时，自动暂停其他视频。
- 视频保留原声，不默认静音。
- 封面图应与视频的有效开始画面一致，替换视频后必须同步重新生成封面。
- “中和休闲”从 `2` 秒的有效画面开始，结束时回到 `2` 秒。

## 当前生效的视频

| 板块 | 项目 | 生效文件 | 时长 | 起播点 |
|---|---|---|---:|---:|
| 商业影像 | 御茶坊 | `public/works/commercial-film-01/preview.mp4` | 63.04 秒 | 0 秒 |
| 商业影像 | 中和休闲 | `public/works/commercial-film-02/preview.mp4` | 90.08 秒 | 2 秒 |
| 商业影像 | 探店分享 | `public/works/commercial-film-03/preview.mp4` | 119.56 秒 | 0 秒 |
| 商业影像 | 水陆集团初五迎财神 | `public/works/commercial-film-04/preview.mp4` | 43.07 秒 | 0 秒 |
| 数字创意 | 玲珑紧致面霜 | `public/works/digital-creation-01/preview.new.mp4` | 31.37 秒 | 0 秒 |
| 数字创意 | 糖果乐园 | `public/works/digital-creation-02/preview.mp4` | 15.10 秒 | 0 秒 |
| 数字创意 | 佰欧克素颜芙蓉套装 | `public/works/digital-creation-03/preview.mp4` | 28.21 秒 | 0 秒 |

## 程序参数位置

- 视频路径、封面版本和起播点：`src/data/cases.ts`
- 进度条与原生视频控件：`src/components/ProjectCard.astro`
- 起播点复位与视频互斥播放：`src/layouts/BaseLayout.astro`

## Netlify 预览站点

- 站点名称：`kh-studio-preview-20260717-1735`
- Site ID：`046960b7-1d4b-48ed-abb4-4c0c618344a4`
- 固定审核别名：`partner-review`
- 固定预览网址：`https://partner-review--kh-studio-preview-20260717-1735.netlify.app`

## 正式上线前验收

1. 执行 `npm run build`，确认所有页面构建成功。
2. 验收商业影像 4 段和数字创意 3 段视频的封面、进度条、声音和完整时长。
3. 确认“中和休闲”首屏为有效画面，并从 2 秒开始播放。
4. 先更新 `partner-review` 预览并复核，通过后再部署正式站点。
