# Configuration

Edit `assets/minecraft/shaders/include/_config.glsl` to customize effects.

### Basic Syntax

```c
TEXT_EFFECT(rgb(R, G, B)) {
    apply_effect();
}
```

### Hex Support

You can pass hex codes through the color helpers, e.g. `rgb(0xRRGGBB)`.

> [!TIP]
> For 32-bit hex values (8-digit hex values like `0xRRGGBBAAu` or `0xAARRGGBBu` representing RGBA/ARGB), it is highly recommended to append the `u` suffix. This ensures GLSL interprets them correctly as unsigned integers, avoiding potential compilation issues.

```c
TEXT_EFFECT(rgb(0xF8F876)) {
    apply_shake();
}

TEXT_EFFECT_WITH_SHADOW(rgb(0xF9F913)) {
    apply_wavy();
    apply_color(rgb(0xFF0000));
}
```

### Shadow Support

> [!WARNING]
> The internal check divides each RGB component by 4 (and rounds the result) to detect if a color is a shadow.
> Therefore, it is highly recommended to use RGB values that are **divisible by 4**. If you assign multiple effects with trigger colors that are very close to each other (difference less than 4), **their calculated shadow colors might overlap, causing incorrect effects to be applied.**

To apply the same effect to both text and shadow:

```c
TEXT_EFFECT_WITH_SHADOW(rgb(255, 255, 86)) {
    apply_shake();
}
```

```c
// Text effect (255, 255, 86)
TEXT_EFFECT(rgb(255, 255, 86)) {
    apply_shake();
}

// Shadow effect (255/4, 255/4, 86/4) = (63, 63, 21)
TEXT_EFFECT(rgb(63, 63, 21)) {
    apply_wavy();
}
```

### Examples

```c
// Yellow text (#FFFF56) triggers shake effect
TEXT_EFFECT(rgb(255, 255, 86)) {
    apply_shake();
}

// Combining Wavy and Rainbow
TEXT_EFFECT(rgb(255, 255, 95)) {
    apply_wavy();
    apply_rainbow();
}

// Custom color with fast shake
TEXT_EFFECT(rgb(200, 100, 50)) {
    apply_shake(2.0, 1.5);
}
```

### Display Color

Use `apply_color()` to display a different color than the trigger color:

```c
// Trigger color: (200, 100, 50)
// Display color: white (255, 255, 255)
TEXT_EFFECT(rgb(200, 100, 50)) {
    apply_shake();
    apply_color(rgb(255, 255, 255));
}
```

This is useful when you want to use a specific trigger color but display the text in a different color.

### Color Helpers

Six helper functions construct color vectors from integer components:

- `rgb(R, G, B)` → `vec3` with components in 0..1
- `rgba(R, G, B, A)` → `vec4`, where `A` is alpha in 0.0..1.0
- `argb(A, R, G, B)` → `vec4`, where `A` is alpha in 0.0..1.0 (alpha-first ordering)
- `rgb(RGB)` → `vec3` with components in 0..1
- `rgba(RGBA)` → `vec4` with components in 0..1
- `argb(ARGB)` → `vec4` with components in 0..1 (alpha-first hex ordering)

```c
apply_color(rgb(255, 80, 80));            // opaque red
apply_color(rgb(0x50FF50));               // opaque green
apply_color(rgba(255, 80, 80, 0.5));      // 50 % transparent red
apply_color(rgba(0x50FF5080u));           // 50 % transparent green
apply_color(argb(0x8050FF50u));           // 50 % transparent green (alpha-first)
apply_gradient(rgba(255, 0, 0, 1.0),
               rgba(0, 0, 255, 0.0), 2.0); // fade-out gradient
```

Most effects accept both `vec3` (RGB) and `vec4` (RGBA) overloads where applicable.

---

### Detailed Functions

### `apply_color`

Overrides the displayed glyph color (independent of the trigger color used in the `TEXT_EFFECT(...)` macro).

- `apply_color(vec3 color)` — RGB only.
- `apply_color(vec4 color)` — RGBA, including alpha transparency (0.0–1.0).

```c
TEXT_EFFECT(rgb(200, 100, 50)) {
    apply_shake();
    apply_color(rgb(255, 255, 255));            // opaque white
}

TEXT_EFFECT(rgb(248, 248, 184)) {
    apply_color(rgba(255, 80, 80, 0.5));        // 50 % transparent red
}
```

### `apply_shake(float speed, float intensity)`

Applies a random shaking animation to the text.

- `speed`: Determines how fast the text shakes.
- `intensity`: Determines the distance the text moves while shaking.

### `apply_wavy(float speed, float amplitude, float xFrequency)`

Applies a sine wave animation to the text vertically.

- `speed`: How fast the wave moves horizontally over time.
- `amplitude`: How high/low the wave goes.
- `xFrequency`: Frequency multiplier across the text width.

### `apply_rainbow(float speed)`

Applies a continuous scrolling rainbow color effect.

- `speed`: How fast the colors cycle.

### `apply_bouncy(float speed, float amplitude)`

Makes the text bounce up and down.

- `speed`: The speed of the bouncing motion.
- `amplitude`: The maximum height of the bounce.

### `apply_blinking(float speed)`

Makes the text turn invisible and visible alternately.

- `speed`: How fast the text blinks.

### `apply_pulse(float speed, float size)`

Makes the text continuously grow and shrink.

- `speed`: The speed of the pulsation.
- `size`: The maximum scale factor during the pulse.

### `apply_spin(float speed)`

Rotates the entire text component around its origin continuously.

- `speed`: The speed of rotation.

### `apply_sequential_spin(float speed)`

Rotates each character sequentially.

- `speed`: The speed of rotation.

### `apply_fade(float speed)`

Fades the text in and out smoothly.

- `speed`: The speed of the fade transition.

### `apply_iterating(float speed, float space)`

Makes characters jump sequentially like a wave.

- `speed`: The speed of the iterating wave.
- `space`: The distance between the jumping characters.

### `apply_glitch(float speed, float intensity)`

Displaces random characters rapidly to create a glitch effect.

- `speed`: How frequently the glitch occurs.
- `intensity`: The maximum random displacement distance.

### `apply_scale(float scale, float offsetX, float offsetY)`

Scales the text and optionally offsets its position.

- `scale`: The multiplier for the text size (e.g., `1.5` for 150%).
- `offsetX` / `offsetY`: Positional shift applied after scaling.

### `apply_offset(float offsetX, float offsetY)`

Moves the text without scaling it.

- `offsetX`: The horizontal shift distance.
- `offsetY`: The vertical shift distance.

### `apply_gradient`

Applies a static linear gradient across the glyph.

- `apply_gradient(vec3 startColor, vec3 endColor, float direction)` — RGB.
- `apply_gradient(vec4 startColor, vec4 endColor, float direction)` — RGBA (color + alpha both interpolated).

`direction`: `0=↑, 1=↗, 2=→, 3=↘, 4=↓, 5=↙, 6=←, 7=↖`.

```c
apply_gradient(rgb(0, 200, 0), rgb(255, 255, 0), 4.0);
```

### `apply_dynamic_gradient`

Animated gradient that sweeps across the glyph over time.

- `apply_dynamic_gradient(vec3 startColor, vec3 endColor, float direction, float speed)`
- `apply_dynamic_gradient(vec4 startColor, vec4 endColor, float direction, float speed)`

`direction` uses the same compass mapping as `apply_gradient`.

```c
apply_dynamic_gradient(rgb(255, 0, 0), rgb(0, 0, 255), 2.0, 500.0);
```

### `apply_lava(float speed)`

A preset dynamic gradient combining red and yellow colors to simulate flowing lava.

- `speed`: How fast the lava flows.

### `apply_aurora`

Applies a flowing aurora-like 3-color gradient that cycles smoothly over time.

- `apply_aurora()` — default colors (pink → green → light blue), default speed.
- `apply_aurora(float speed)` — custom speed.
- `apply_aurora(vec3 c1, vec3 c2, vec3 c3, float speed)` — custom RGB colors and speed.
- `apply_aurora(vec4 c1, vec4 c2, vec4 c3, float speed)` — custom RGBA colors and speed.

Default speed: `500.0`. Default colors: pink (`1.0, 0.3, 0.7`), green (`0.3, 1.0, 0.6`), light blue (`0.4, 0.6, 1.0`). The cycle wraps fully (c1→c2→c3→c1) with no discontinuity.

```c
TEXT_EFFECT(rgb(248, 248, 160)) {
    apply_aurora();  // default pink → green → light blue cycle
}
```

### `apply_split`

Cuts each glyph horizontally at its vertical midpoint and smoothly animates the
top half between the shifted-left position and the original position. The
bottom half always renders at the original position.

- `apply_split()` — default intensity and speed.
- `apply_split(float intensity)` — pixel-offset amount of the top-half shift.
- `apply_split(float intensity, float speed)` — also control the oscillation rate.

The shift is driven by `sin(GameTime * speed * 3000.0)` mapped to 0..1, so the
top half slides smoothly back and forth. Cut areas (right side of top half /
left side of bottom half during transition) are discarded as the half slides.

Default intensity: `1.5`, default speed: `1.0`.

```c
TEXT_EFFECT_WITH_SHADOW(rgb(248, 248, 164)) {
    apply_split();
    apply_color(rgb(255, 100, 200));
}
// faster oscillation
apply_split(1.5, 2.0);
```

### `apply_outline`

Draws a colored outline around glyph edges via 8-direction neighbor sampling in the fragment shader. Cannot be combined with other color effects (rainbow / gradient / aurora) — the body color comes from `apply_color()`.

- `apply_outline()` — default black outline, thickness `1.0`.
- `apply_outline(vec3 color)` — custom outline color.
- `apply_outline(vec3 color, float thickness)` — custom color and thickness in pixels.
- `apply_outline(vec4 color, float thickness)` — custom RGBA color and thickness.

```c
TEXT_EFFECT(rgb(248, 248, 172)) {
    apply_outline(rgb(0, 0, 0), 1.0);
    apply_color(rgb(255, 255, 255));
}
```

### `apply_hatch`

Overlays an animated diagonal hatching pattern (45-degree stripes) that sweeps across each glyph over time. Stripes use a hard-edged 25% duty cycle — a thin stripe band shows `effectColor`, the remainder shows `baseColor`.

- `apply_hatch()` — default white hatching.
- `apply_hatch(float speed)` — custom animation speed.
- `apply_hatch(vec3 color, float speed, float density)` — custom color, speed, and stripe density (number of stripes across the glyph diagonal — e.g. `3.0` for 3 stripes).
- `apply_hatch(vec4 color, float speed, float density)` — custom RGBA color, speed, and density.

`speed` is applied with an internal multiplier of `2.0`, so `speed=1` produces approximately 1 full stripe cycle per second at the default density. Values around `1.0`–`3.0` give a natural sweep rate.

```c
TEXT_EFFECT(rgb(248, 248, 176)) {
    apply_color(rgb(0, 0, 0));
    apply_hatch(rgb(255, 255, 255), 1.0, 3.0);
}
```

### `apply_neon`

Adds a soft glow halo around each glyph via radial sampling, plus a subtle
compound flicker. Setting flicker speed to `0` disables the flicker entirely
for a steady glow.

- `apply_neon()` — default cyan neon.
- `apply_neon(vec3 color)` — custom glow color.
- `apply_neon(vec3 color, float intensity)` — custom color and halo strength.
- `apply_neon(vec4 color, float intensity, float speed)` — custom RGBA color, intensity, and flicker speed (0 = no flicker).

Defaults: color `(128, 230, 255)`, intensity `1.5`, speed `1.0`.

```c
// Default subtle flicker
TEXT_EFFECT(rgb(248, 248, 180)) {
    apply_neon(rgb(80, 220, 255), 1.5);
}

// Steady glow (no flicker)
apply_neon(rgb(255, 100, 200), 2.0, 0.0);
```

### `apply_chromatic`

Samples the glyph texture three times with horizontal UV offsets and routes each sample to a different color channel (R left, G center, B right), composited additively for a classic chromatic aberration fringe. The offset oscillates over time.

- `apply_chromatic()` — default intensity (`1.5`), default speed (`1.0`).
- `apply_chromatic(float intensity)` — pixel offset radius of the color fringe.
- `apply_chromatic(float intensity, float speed)` — custom radius and animation speed.

Default intensity: `1.5`. Default speed: `1.0`.

```c
TEXT_EFFECT(rgb(248, 248, 188)) {
    apply_chromatic(1.0, 1.0);
    apply_color(rgb(255, 255, 255));
}
```

### `apply_extrude`

Stacks multiple shadow copies in the down-right direction to create a pressed/extruded 3D appearance — similar to CSS `text-shadow` stacking. The glyph face renders at full color; each successive layer is either progressively darker (default) or interpolated toward an explicit end color.

- `apply_extrude()` — default depth (`1.0`), default layers (`3`).
- `apply_extrude(float depth)` — pixels per shadow layer step.
- `apply_extrude(float depth, float layers)` — custom depth and number of shadow layers (max 16).
- `apply_extrude(float depth, float layers, vec3 endColor)` — shadow layers are linearly interpolated from the main glyph color (closest layer) to `endColor` (deepest layer).
- `apply_extrude(float depth, float layers, vec4 endColor)` — RGBA variant; interpolates both color and alpha toward `endColor`.
- `apply_extrude(float depth, float layers, vec3 c1, vec3 c2, vec3 c3)` — explicit 3-color gradient (start/mid/end).
- `apply_extrude(float depth, float layers, vec4 c1, vec4 c2, vec4 c3)` — RGBA variant of the 3-color gradient.

When `endColor` is given, each shadow layer's color is linearly interpolated from the main glyph color (the closest layer) to `endColor` (the deepest layer). Combine with `apply_color()` to control the main glyph color.

When 3 colors are given, layers are interpolated through `c1` → `c2` → `c3`. With `layers=3`, each layer matches one color exactly. With more layers, intermediate values are blended smoothly through the 3 stops.

Default depth: `1.0`. Default layers: `3.0`.

```c
// Auto-darken (default)
TEXT_EFFECT(rgb(248, 248, 192)) {
    apply_extrude(1.0, 3.0);
    apply_color(rgb(255, 200, 0));
}
// Gradient to endColor
TEXT_EFFECT(rgb(248, 248, 204)) {
    apply_extrude(1.0, 5.0, rgb(80, 40, 0));
    apply_color(rgb(255, 220, 100));
}
// 3-color gradient (start/mid/end)
TEXT_EFFECT(rgb(248, 248, 208)) {
    apply_extrude(1.0, 5.0, rgb(255, 220, 100), rgb(180, 100, 30), rgb(60, 30, 0));
    apply_color(rgb(255, 240, 180));
}
```

### `apply_noise`

Randomly displaces UV coordinates per fragment using a hash noise function, changing in discrete time steps for a static/glitch look. Includes a per-frame brightness flicker.

- `apply_noise()` — default intensity (`1.0`), default speed (`1.0`).
- `apply_noise(float intensity)` — pixel displacement radius.
- `apply_noise(float intensity, float speed)` — custom radius and frame-change rate.

Default intensity: `1.0`. Default speed: `1.0`.

```c
TEXT_EFFECT(rgb(248, 248, 196)) {
    apply_noise(1.0, 1.0);
    apply_color(rgb(255, 255, 255));
}
```

### `apply_liquid`

Displaces UV coordinates using crossed `sin`/`cos` products for a smooth, organic warp that resembles liquid turbulence. Animates continuously over time.

- `apply_liquid()` — default intensity (`1.0`), default speed (`1.0`).
- `apply_liquid(float intensity)` — pixel displacement radius.
- `apply_liquid(float intensity, float speed)` — custom radius and animation speed.

Default intensity: `1.0`. Default speed: `1.0`.

```c
TEXT_EFFECT(rgb(248, 248, 200)) {
    apply_liquid(1.0, 1.0);
    apply_color(rgb(80, 200, 220));
}
```

### `apply_water`

Fills the glyph interior with rising water up to a configurable level, with a
wavy animated surface and a depth gradient. The portion above the water line
is rendered using the base color (combine with `apply_color()`).

- `apply_water()` — default cyan-blue water at 55 % level.
- `apply_water(vec3 color)` — custom water color.
- `apply_water(vec4 color)` — RGBA variant.
- `apply_water(vec3 color, float level)` — `level` 0..1 (0 = empty, 1 = full).
- `apply_water(vec3 color, float level, float amplitude, float speed)` — wave amplitude and animation speed.
- `apply_water(vec4 color, float level, float amplitude, float speed)` — RGBA variant.
- `apply_water(vec3 color, float level, float amplitude, float speed, float frequency)` — also tune wave density.

Defaults: color `(51, 153, 242)`, level `0.55`, amplitude `1.0`, speed `1.0`, frequency `1.5`.

```c
// Default 55 % cyan-blue water
TEXT_EFFECT(rgb(248, 248, 212)) {
    apply_water(rgb(40, 150, 240));
    apply_color(rgb(60, 60, 80));   // dry portion
}
// 80 % filled, custom amplitude/speed
TEXT_EFFECT(rgb(248, 248, 216)) {
    apply_water(rgb(0, 200, 200), 0.8, 1.5, 1.2);
    apply_color(rgb(40, 60, 60));
}
```
