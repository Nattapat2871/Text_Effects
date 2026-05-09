# TheSalt's Text Effects

Add dynamic text animations to your Minecraft world! This resource pack provides **customizable text effects**. Use with `/title`, `/tellraw`, and similar text components.

> This resource pack is **not compatible** with other packs that use the `rendertype_text` core shader.

## How It Works

Define color-to-effect mappings in `_config.glsl`. When text uses a matching RGB color, the configured effect is applied.

## Preview

![23](https://github.com/user-attachments/assets/1ed9fd46-a769-4256-bc36-758adc431602)

<img width="1228" height="668" alt="new1" src="https://github.com/user-attachments/assets/fd819652-8fa1-41ab-b177-50e09646ea2d" />

<img width="1920" height="1009" alt="2026-03-08_22 50 06" src="https://github.com/user-attachments/assets/3c988bdb-a60d-4db7-ba49-a50a3ab8f918" />

<img width="1920" height="1009" alt="2026-03-08_22 49 24" src="https://github.com/user-attachments/assets/a4d76af1-aae6-4132-b3ac-4e39eb6344f9" />

## Can I use this on my map/server?

Yes, provided that you keep the [license file](./LICENSE) within the resource pack and add `Credit. TheSalt's Text Effects` to the description in `pack.mcmeta`.

## Available Effects

| Effect                                                                                                                               | Description               |
| ------------------------------------------------------------------------------------------------------------------------------------ | ------------------------- |
| [`apply_shake(speed, intensity)`](./CONFIGURATION.md#apply_shakefloat-speed-float-intensity)                                                           | Random shaking            |
| [`apply_wavy(speed, amplitude, xFrequency)`](./CONFIGURATION.md#apply_wavyfloat-speed-float-amplitude-float-xfrequency)                                | Wave animation            |
| [`apply_rainbow(speed)`](./CONFIGURATION.md#apply_rainbowfloat-speed)                                                                                  | Rainbow color cycle       |
| [`apply_bouncy(speed, amplitude)`](./CONFIGURATION.md#apply_bouncyfloat-speed-float-amplitude)                                                         | Bounce animation          |
| [`apply_blinking(speed)`](./CONFIGURATION.md#apply_blinkingfloat-speed)                                                                                | Blink on/off              |
| [`apply_pulse(speed, size)`](./CONFIGURATION.md#apply_pulsefloat-speed-float-size)                                                                     | Grow/Shrink animation     |
| [`apply_spin(speed)`](./CONFIGURATION.md#apply_spinfloat-speed)                                                                                        | Rotation                  |
| [`apply_sequential_spin(speed)`](./CONFIGURATION.md#apply_sequential_spinfloat-speed)                                                                  | Sequential character spin |
| [`apply_fade(speed)`](./CONFIGURATION.md#apply_fadefloat-speed)                                                                                        | Fade in/out               |
| [`apply_iterating(speed, space)`](./CONFIGURATION.md#apply_iteratingfloat-speed-float-space)                                                           | Sequential jump           |
| [`apply_glitch(speed, intensity)`](./CONFIGURATION.md#apply_glitchfloat-speed-float-intensity)                                                         | Random displacement       |
| [`apply_scale(scale, offsetX, offsetY)`](./CONFIGURATION.md#apply_scalefloat-scale-float-offsetx-float-offsety)                                        | Scale text                |
| [`apply_offset(offsetX, offsetY)`](./CONFIGURATION.md#apply_offsetfloat-offsetx-float-offsety)                                                         | Move text position        |
| [`apply_gradient(startColor, endColor, direction)`](./CONFIGURATION.md#apply_gradient)                    | Static linear gradient    |
| [`apply_dynamic_gradient(start, end, dir, speed)`](./CONFIGURATION.md#apply_dynamic_gradient) | Animated moving gradient  |
| [`apply_lava(speed)`](./CONFIGURATION.md#apply_lavafloat-speed)                                                                                        | Flowing lava effect       |
| [`apply_color(color)`](./CONFIGURATION.md#apply_color)                                                                                                  | Override display color    |
| [`apply_aurora(c1, c2, c3, speed)`](./CONFIGURATION.md#apply_aurora)                                                                                   | Flowing 3-color aurora    |
| [`apply_split(intensity, speed)`](./CONFIGURATION.md#apply_split)                                                                                       | Animated horizontal split |
| [`apply_outline(color, thickness)`](./CONFIGURATION.md#apply_outline)                                                                                  | Glyph outline (fragment)  |
| [`apply_hatch(color, speed, density)`](./CONFIGURATION.md#apply_hatch)                                                                                 | Diagonal hatching (frag)  |
| [`apply_neon(color, intensity, speed)`](./CONFIGURATION.md#apply_neon)                                                                                  | Neon glow (fragment)      |
| [`apply_chromatic(intensity, speed)`](./CONFIGURATION.md#apply_chromatic)                                                                              | Chromatic aberration frag |
| [`apply_extrude(depth, layers)`](./CONFIGURATION.md#apply_extrude)                                                                                     | 3D depth shadow (frag)    |
| [`apply_noise(intensity, speed)`](./CONFIGURATION.md#apply_noise)                                                                                      | Noise / static (fragment) |
| [`apply_liquid(intensity, speed)`](./CONFIGURATION.md#apply_liquid)                                                                                    | Liquid morph (fragment)   |
| [`apply_water(color, level, amp, speed)`](./CONFIGURATION.md#apply_water)                                                                              | Wavy water-fill animation |

---

## Configuration

See [CONFIGURATION.md](./CONFIGURATION.md) for the configuration syntax, examples, and detailed function reference.

---

## Special Thanks

좌우반전 코드를 제공해 주신 [@베스트견과류](https://github.com/bestnuts) 님에게 감사를 표합니다.

## License

This code is under MIT License

This project includes code from [Text-Effects-by-Akis](https://github.com/YeahAkis/Text-Effects-by-Akis).
