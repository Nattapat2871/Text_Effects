# Configuration

Edit `assets/minecraft/shaders/include/_config.glsl` to customize effects.

### Basic Syntax

```glsl
TEXT_EFFECT(R, G, B) {
    apply_effect();
}
```

### Shadow Support

> [!WARNING]
> The internal check divides each RGB component by 4 (and rounds the result) to detect if a color is a shadow.
> Therefore, it is highly recommended to use RGB values that are **divisible by 4**. If you assign multiple effects with trigger colors that are very close to each other (difference less than 4), **their calculated shadow colors might overlap, causing incorrect effects to be applied.**

To apply the same effect to both text and shadow:

```glsl
TEXT_EFFECT_WITH_SHADOW(255, 255, 86) {
    apply_shake();
}
```

```glsl
// Text effect (255, 255, 86)
TEXT_EFFECT(255, 255, 86) {
    apply_shake();
}

// Shadow effect (255/4, 255/4, 86/4) = (63, 63, 21)
TEXT_EFFECT(63, 63, 21) {
    apply_wavy();
}
```

### Examples

```glsl
// Yellow text (#FFFF56) triggers shake effect
TEXT_EFFECT(255, 255, 86) {
    apply_shake();
}

// Combining Wavy and Rainbow
TEXT_EFFECT(255, 255, 95) {
    apply_wavy();
    apply_rainbow();
}

// Custom color with fast shake
TEXT_EFFECT(200, 100, 50) {
    apply_shake(2.0, 1.5);
}
```

### Display Color

Use `apply_color()` to display a different color than the trigger color:

```glsl
// Trigger color: (200, 100, 50)
// Display color: white (255, 255, 255)
TEXT_EFFECT(200, 100, 50) {
    apply_shake();
    apply_color(255, 255, 255);
}
```

This is useful when you want to use a specific trigger color but display the text in a different color.

---

### Detailed Functions

### `apply_color(vec3 color)`

Changes the display color of the text independently from the trigger color.

- `color`: The RGB color vector, created using `rgb(R, G, B)`.

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

### `apply_gradient(vec3 startColor, vec3 endColor, float direction)`

Applies a static linear gradient across the text.

- `startColor` / `endColor`: RGB color vectors using `rgb(R, G, B)`.
- `direction`: Angle/direction of the gradient.

### `apply_dynamic_gradient(vec3 startColor, vec3 endColor, float direction, float speed)`

Applies an animated gradient that sweeps across the text.

- `startColor` / `endColor`: RGB color vectors via `rgb(R, G, B)`.
- `direction`: Angle/direction of the gradient.
- `speed`: How fast the gradient moves.

### `apply_lava(float speed)`

A preset dynamic gradient combining red and yellow colors to simulate flowing lava.

- `speed`: How fast the lava flows.

### `apply_color(vec4 color)`

Changes the display color including alpha transparency.

- `color`: An RGBA color vector created with `rgba(R, G, B, A)`, where `A` is alpha in the range `0.0`–`1.0`.

```glsl
TEXT_EFFECT(248, 248, 184) {
    apply_color(rgba(255, 80, 80, 0.5)); // 50% transparent red
}
```

### `apply_gradient(vec4 startColor, vec4 endColor, float direction)`

RGBA overload of `apply_gradient` — interpolates both color and alpha across the glyph.

### `apply_dynamic_gradient(vec4 startColor, vec4 endColor, float direction, float speed)`

RGBA overload of `apply_dynamic_gradient` — animates both color and alpha.

### `apply_aurora`

Applies a flowing aurora-like 3-color gradient that cycles smoothly over time.

- `apply_aurora()` — default colors (pink → green → light blue), default speed.
- `apply_aurora(float speed)` — custom speed.
- `apply_aurora(vec3 c1, vec3 c2, vec3 c3, float speed)` — custom RGB colors and speed.
- `apply_aurora(vec4 c1, vec4 c2, vec4 c3, float speed)` — custom RGBA colors and speed.

Default speed: `500.0`. Default colors: pink (`1.0, 0.3, 0.7`), green (`0.3, 1.0, 0.6`), light blue (`0.4, 0.6, 1.0`). The cycle wraps fully (c1→c2→c3→c1) with no discontinuity.

### `apply_split`

Cuts each glyph cleanly at its vertical midpoint in the fragment shader. The bottom half renders normally; the top half is shifted left by sampling the texture at a positive X offset. No animation — the split is static.

- `apply_split()` — default intensity.
- `apply_split(float intensity)` — custom pixel offset of the top half (higher = more shift).

Default intensity: `1.5`.

### `apply_outline`

Draws a colored outline around glyph edges via 8-direction neighbor sampling in the fragment shader. Cannot be combined with other color effects (rainbow / gradient / aurora) — the body color comes from `apply_color()`.

- `apply_outline()` — default black outline, thickness `1.0`.
- `apply_outline(vec3 color)` — custom outline color.
- `apply_outline(vec3 color, float thickness)` — custom color and thickness in pixels.
- `apply_outline(vec4 color, float thickness)` — custom RGBA color and thickness.

### `apply_hatch`

Overlays an animated diagonal hatching pattern (45-degree stripes) that sweeps across each glyph over time. Stripes use a hard-edged 25% duty cycle — a thin stripe band shows `effectColor`, the remainder shows `baseColor`.

- `apply_hatch()` — default white hatching.
- `apply_hatch(float speed)` — custom animation speed.
- `apply_hatch(vec3 color, float speed, float density)` — custom color, speed, and stripe density (number of stripes across the glyph diagonal — e.g. `3.0` for 3 stripes).
- `apply_hatch(vec4 color, float speed, float density)` — custom RGBA color, speed, and density.

### `apply_neon`

Adds a soft glow halo around each glyph via radial sampling, plus a subtle flicker.

- `apply_neon()` — default cyan neon.
- `apply_neon(vec3 color)` — custom glow color.
- `apply_neon(vec3 color, float intensity)` — custom color and halo strength.
- `apply_neon(vec4 color, float intensity, float speed)` — custom RGBA color, intensity, and flicker speed.
