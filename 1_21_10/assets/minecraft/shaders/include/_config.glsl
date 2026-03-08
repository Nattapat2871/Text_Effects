// ============================================================
// TEXT EFFECTS CONFIGURATION
// ============================================================
// Define color-to-effect mappings here.
// Usage: TEXT_EFFECT(R, G, B) { apply_effect(); }
// ============================================================

// --- 1. Basic Effects ---

// Shake (#FFFF56)
TEXT_EFFECT(255, 255, 86) {
    apply_shake();
}

// Wavy (#FFFF57)
TEXT_EFFECT(255, 255, 87) {
    apply_wavy();
}

// Rainbow (#FFFF58)
TEXT_EFFECT(255, 255, 88) {
    apply_rainbow();
}

// Bouncy (#FFFF59)
TEXT_EFFECT(255, 255, 89) {
    apply_bouncy();
}

// Blinking (#FFFF5A)
TEXT_EFFECT(255, 255, 90) {
    apply_blinking();
}

// Pulse (#FFFF5B)
TEXT_EFFECT(255, 255, 91) {
    apply_pulse();
}

// --- 2. Motion Effects ---

// Spin (#FFFF5C)
TEXT_EFFECT(255, 255, 92) {
    apply_spin();
}

// Sequential Spin (#FFFF5D)
TEXT_EFFECT(255, 255, 93) {
    apply_sequential_spin();
}

// Fade (#FFFF5E)
TEXT_EFFECT(255, 255, 94) {
    apply_fade();
}

// Iterating Jump (#FFFF5F)
TEXT_EFFECT(255, 255, 95) {
    apply_iterating();
}

// --- 3. Special Effects ---

// Glitch (#FFFF60)
TEXT_EFFECT(255, 255, 96) {
    apply_glitch();
}

// --- 4. Scale / Offset Effects ---

// Scale x1.5 (#FFFF6A)
TEXT_EFFECT_WITH_SHADOW(255, 255, 106) {
    apply_scale(5);
}

// Offset up (#FFFF6B)
TEXT_EFFECT_WITH_SHADOW(255, 255, 108) {
    apply_offset(0.0, 40.0);
}

// --- 5. Gradient Effects ---

// Gradient: Green → Yellow, Down (#FFFF64)
TEXT_EFFECT(255, 255, 100) {
    apply_gradient(rgb(0, 200, 0), rgb(255, 255, 0), 4.0);
}

// Dynamic Gradient: Red → Blue, Right (#FFFF67)
TEXT_EFFECT(255, 255, 103) {
    apply_dynamic_gradient(rgb(255, 0, 0), rgb(0, 0, 255), 2.0, 500.0);
}

// Dynamic Gradient: Green → Yellow, Down (#FFFF68)
TEXT_EFFECT(255, 255, 104) {
    apply_dynamic_gradient(rgb(0, 200, 0), rgb(255, 255, 0), 4.0, 500.0);
}

// Lava (#FFFF69)
TEXT_EFFECT(255, 255, 105) {
    apply_lava();
}

// --- 5. Combinations ---

// Wavy + Rainbow (#FFFF61)
TEXT_EFFECT(255, 255, 97) {
    apply_wavy();
    apply_rainbow();
}

// Bouncy + Rainbow (#FFFF62)
TEXT_EFFECT(255, 255, 98) {
    apply_bouncy();
    apply_rainbow();
}

// Custom Parameters (Fast Shake) (#C86432)
TEXT_EFFECT(200, 100, 50) {
    apply_shake(2.0, 1.5);
    apply_color(rgb(255, 255, 85));
}

// Shadow Support Example (Text + Shadow)
TEXT_EFFECT_WITH_SHADOW(255, 200, 200) {
    apply_wavy(5000.0, 0.5);
}
