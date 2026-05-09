// Split effect: cleanly cuts the glyph horizontally at vertical midpoint
// and shifts the top half to the left.  Bottom half renders normally.
// Requires text_data.glsl to be imported before this file.
// fshEffectParams.x = intensity (pixel offset of the top half, positive shifts left)

void applySplitEffect(vec2 uv,
                         vec4 baseColor,
                         vec4 effectColor,
                         vec4 effectParams,
                         vec3 glyphT0, vec3 glyphT1, vec3 glyphT2, vec3 glyphT3,
                         sampler2D tex,
                         out vec4 result) {
    vec2 uvMin, uvMax;
    calculateUVBounds(glyphT0, glyphT1, glyphT2, glyphT3, uvMin, uvMax);
    if (uvMax.x < uvMin.x || uvMax.y < uvMin.y) {
        uvMin = vec2(0.0);
        uvMax = vec2(1.0);
    }

    vec2 uvSize = uvMax - uvMin;
    float vNorm = (uvSize.y > 0.0001) ? (uv.y - uvMin.y) / uvSize.y : 0.5;

    // In MC text rendering vid 0/3 occupy the screen-top half and have lower UV.y
    // (uvMin.y), so vNorm < 0.5 corresponds to the top half on screen.
    bool isTopHalf = vNorm < 0.5;

    // The vertex shader expanded the left vertices (vid 0/1) by intensity*1.6 px.
    // This stretches the position-to-UV mapping over the expanded quad.  Re-scale
    // sampling so each half renders the full-size original glyph at the desired
    // screen position (top shifted left, bottom at original).
    // shiftRatio assumes default-font 8-px glyph; close enough for most fonts.
    float shiftRatio = clamp(effectParams.x * 0.2, 0.05, 0.6);
    float scaledU;
    if (isTopHalf) {
        // Top half: shifted left by `shiftRatio` of the original glyph width.
        scaledU = (uv.x - uvMin.x) * (1.0 + shiftRatio);
        if (scaledU > uvSize.x) {
            discard; // cut area on the right of the top half
        }
    } else {
        // Bottom half: stays at original screen position.
        scaledU = (uv.x - uvMin.x) * (1.0 + shiftRatio) - shiftRatio * uvSize.x;
        if (scaledU < 0.0) {
            discard; // expanded-left area, not part of original quad
        }
    }
    vec2 sampleUV = vec2(uvMin.x + scaledU, uv.y);

    float a = texture(tex, sampleUV).a;
    if (a < 0.1) {
        discard;
    }

    result = vec4(baseColor.rgb, a * baseColor.a);
}
