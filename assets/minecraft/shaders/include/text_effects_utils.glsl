#moj_import <common.glsl>
#moj_import <offset.glsl>
#moj_import <defaults.glsl>
#moj_import <rainbow.glsl>
#moj_import <wavy.glsl>
#moj_import <bouncy.glsl>
#moj_import <blinking.glsl>
#moj_import <pulse.glsl>
#moj_import <spin.glsl>
#moj_import <shake.glsl>
#moj_import <fade.glsl>
#moj_import <iterating.glsl>
#moj_import <glitch.glsl>
#moj_import <gradient.glsl>
#moj_import <scale.glsl>
#moj_import <text_effects_api.glsl>
#moj_import <apply_effect.glsl>

// ============================================================
// TEXT EFFECTS - Config-based System
// ============================================================
// Edit _config.glsl to customize color-effect mappings
// ============================================================

// Helper function to check shadow match and update state
bool checkAndSetShadow(ivec3 c, int R, int G, int B) {
    // Check main color (exact match)
    if (c.r == R && c.g == G && c.b == B) {
        return true;
    }
    // Check shadow color (exact match, approx 25% of main)
    if (c.r == int(R/4) && c.g == int(G/4) && c.b == int(B/4)) {
        currentIsShadow = true;
        return currentIsShadow;
    }
    return false;
}

// TEXT_EFFECT macro: matches RGB color only (exact match)
#define TEXT_EFFECT(R, G, B) \
    if (c.r == R && c.g == G && c.b == B)

// TEXT_EFFECT_WITH_SHADOW macro: matches RGB color AND its shadow (exact match)
#define TEXT_EFFECT_WITH_SHADOW(R, G, B) \
    if (checkAndSetShadow(c, R, G, B))

void applyTextEffects() {
    vec4 vertex = vec4(Position, 1.0);
    ivec3 c = ivec3(Color.rgb * 255.0 + 0.5);

    // Initialize global state
    currentVertex = vertex;
    currentBaseColor = Color;
    currentIsShadow = false;
    currentApplyToShadow = false;

    // ============================================
    // Config-based color-effect mappings
    // ============================================
    #moj_import <_config.glsl>

    // If any effect was applied, execute it
    if (hasAnyEffect()) {
        applyEffect(currentVertex, currentBaseColor, currentIsShadow);
        return;
    }

    // === No effect matched, render normally ===
    applyProjection(vertex);
    // Apply same depth bias as the effect path so that effect-triggered shadows
    // don't z-fight or render in front of normally-rendered main text.
    gl_Position.z -= 0.001;
    applyColorTexture();
    finalize();
}
